variable "aws_region" { 
    type=string 
    default="us-east-1" 
    }
variable "vpc_name" { 
    type=string 
    default="demo-vpc" 
    }
variable "vpc_cidr" { 
    type=string 
    default="10.0.0.0/16" 
    }
variable "public_subnet_cidr" {
     type=string 
     default="10.0.1.0/24" 
     }
variable "private_subnet_cidr" {
     type=string 
     default="10.0.2.0/24" 
     }
variable "instance_ami" {
     type=string 
     default="ami-0ecb62995f68bb549" 
     }
variable "instance_type" {
     type=string 
     default="t3.micro" 
     }
variable "ssh_key_name" {
     type=string 
     default = "ec2test"  #ADD YOUR OWN AWS KEY PAIR
     }
