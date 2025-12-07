resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.project_name}-vpc"
  }
}

# --- Internet Gateway and Public Subnets ---

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.project_name}-igw"
  }
}

# Public Subnet in AZ 1
resource "aws_subnet" "public_az1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr_blocks[0]
  availability_zone       = var.availability_zones[0]
  map_public_ip_on_launch = true # EC2 in this subnet get a public IP

  tags = {
    Name    = "${var.project_name}-public-az1"
    Tier    = "Public"
  }
}

# Public Subnet in AZ 2 (For High Availability - optional but recommended)
resource "aws_subnet" "public_az2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr_blocks[1]
  availability_zone       = var.availability_zones[1]
  map_public_ip_on_launch = true

  tags = {
    Name    = "${var.project_name}-public-az2"
    Tier    = "Public"
  }
}

# Route Table for Public Subnets
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0" # Default route for all traffic
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "${var.project_name}-public-rt"
  }
}

# Associate Public Subnets with Public Route Table
resource "aws_route_table_association" "public_az1" {
  subnet_id      = aws_subnet.public_az1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_az2" {
  subnet_id      = aws_subnet.public_az2.id
  route_table_id = aws_route_table.public.id
}

# --- NAT Gateway and Private Subnets ---

# Allocate an Elastic IP for the NAT Gateway
resource "aws_eip" "nat_az1" {
  vpc = true # Specify this is for a VPC

  tags = {
    Name = "${var.project_name}-nat-eip-az1"
  }
}

# Create the NAT Gateway in one of the Public Subnets
resource "aws_nat_gateway" "az1" {
  allocation_id = aws_eip.nat_az1.id
  subnet_id     = aws_subnet.public_az1.id # Must be in a Public Subnet

  tags = {
    Name = "${var.project_name}-nat-gw-az1"
  }
  # Needs to depend on the Internet Gateway being ready for connection
  depends_on = [aws_internet_gateway.main]
}

# Private Subnet in AZ 1
resource "aws_subnet" "private_az1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidr_blocks[0]
  availability_zone = var.availability_zones[0]

  tags = {
    Name    = "${var.project_name}-private-az1"
    Tier    = "Private"
  }
}

# Private Subnet in AZ 2
resource "aws_subnet" "private_az2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidr_blocks[1]
  availability_zone = var.availability_zones[1]

  tags = {
    Name    = "${var.project_name}-private-az2"
    Tier    = "Private"
  }
}

# Route Table for Private Subnets
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0" # Default route for all traffic
    nat_gateway_id = aws_nat_gateway.az1.id # Route traffic to the NAT Gateway
  }

  tags = {
    Name = "${var.project_name}-private-rt"
  }
}

# Associate Private Subnets with Private Route Table
resource "aws_route_table_association" "private_az1" {
  subnet_id      = aws_subnet.private_az1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_az2" {
  subnet_id      = aws_subnet.private_az2.id
  route_table_id = aws_route_table.private.id
}
