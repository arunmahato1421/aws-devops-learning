module "vpc" {
  source              = "./modules/vpc"
  aws_region          = var.aws_region
  vpc_name            = var.vpc_name
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  instance_ami        = var.instance_ami
  instance_type       = var.instance_type
  ssh_key_name        = var.ssh_key_name
}
