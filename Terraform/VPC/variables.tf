variable "project_name" {
  description = "Name to prefix all resources with"
  type        = string
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr_blocks" {
  description = "List of CIDR blocks for the Public Subnets (e.g., [\"10.0.1.0/24\", \"10.0.2.0/24\"])"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidr_blocks" {
  description = "List of CIDR blocks for the Private Subnets (e.g., [\"10.0.101.0/24\", \"10.0.102.0/24\"])"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "availability_zones" {
  description = "List of two availability zones to deploy resources into"
  type        = list(string)
}