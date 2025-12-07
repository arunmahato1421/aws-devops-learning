data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  az0 = data.aws_availability_zones.available.names[0]
  name_prefix = var.vpc_name != "" ? var.vpc_name : "demo-vpc"
}

# VPC
resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${local.name_prefix}-vpc"
  }
}

# Internet Gateway (for public subnet)
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${local.name_prefix}-igw"
  }
}

# Public Subnet
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = local.az0
  map_public_ip_on_launch = true

  tags = {
    Name = "${local.name_prefix}-public-subnet"
  }
}

# Private Subnet
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = local.az0

  tags = {
    Name = "${local.name_prefix}-private-subnet"
  }
}

# Public Route Table (route 0.0.0.0/0 -> IGW)
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${local.name_prefix}-public-rt"
  }
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# Elastic IP for NAT Gateway
resource "aws_eip" "nat_eip" {
  domain = "vpc"
}
# NAT Gateway in public subnet (so private subnet can reach internet)
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public.id
}
# Private Route Table (route 0.0.0.0/0 -> NAT)
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "${local.name_prefix}-private-rt"
  }
}

resource "aws_route_table_association" "private_assoc" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}

# Public SG: allow SSH from internet and allow internal traffic to private
resource "aws_security_group" "public_sg" {
  name        = "${local.name_prefix}-public-sg"
  description = "Allow SSH from internet and internal comms"
  vpc_id      = aws_vpc.this.id

  # SSH from internet (change to your IP for production)
  ingress {
    description = "SSH from internet"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all egress
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "${local.name_prefix}-public-sg" }
}

# Private SG: allow all from VPC (including public instance), allow outbound via NAT
resource "aws_security_group" "private_sg" {
  name        = "${local.name_prefix}-private-sg"
  description = "Allow internal VPC traffic; outbound via NAT"
  vpc_id      = aws_vpc.this.id

  ingress {
    description = "Allow all from VPC CIDR"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    description = "Allow all outbound (NAT will be used)"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "${local.name_prefix}-private-sg" }
}

# Optional: allow the private SG to accept traffic from the public instance's SG specifically
resource "aws_security_group_rule" "allow_public_sg_to_private" {
  type                     = "ingress"
  security_group_id        = aws_security_group.private_sg.id
  source_security_group_id = aws_security_group.public_sg.id
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  description              = "Allow all traffic from public instance SG"
}

# Public EC2 Instance (has public IP)
resource "aws_instance" "public" {
  ami                         = var.instance_ami
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.public_sg.id]
  associate_public_ip_address = true
  key_name                    = var.ssh_key_name

  tags = {
    Name = "${local.name_prefix}-public-instance"
  }
}

# Private EC2 Instance (no public IP)
resource "aws_instance" "private" {
  ami                    = var.instance_ami
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.private.id
  vpc_security_group_ids = [aws_security_group.private_sg.id]
  associate_public_ip_address = false
  key_name               = var.ssh_key_name

  tags = {
    Name = "${local.name_prefix}-private-instance"
  }
}
output "public_instance_id" {
  value = aws_instance.public.id
}

output "public_instance_public_ip" {
  value = aws_instance.public.public_ip
}

output "private_instance_id" {
  value = aws_instance.private.id
}

output "private_instance_private_ip" {
  value = aws_instance.private.private_ip
}

output "vpc_id" {
  value = aws_vpc.this.id
}

