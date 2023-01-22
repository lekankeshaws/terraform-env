# Terraform block
terraform {
    required_version = ">=1.1.0"

  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 4.0"
    }
  }
}

# Provider Block
provider "aws" {
    region = "us-east-1"
    profile = "iamadmin"
  
}

########### Resource Block ####################

# Creating VPC
resource "aws_vpc" "dev-vpc" {
    cidr_block = var.cidr_block
    instance_tenancy = "default"

    tags = {
        Name = "dev-vpc"
    }
}

# Creating EC2
resource "aws_instance" "test-server" {
  ami           = var.ami_id # us-east-1
  instance_type = "t2.micro"

  tags = {
    Name = "test-server"
  }
}

############ Variable Block ##############

variable "ami_id" {
  type = string
  description = "ami id"
  default = "ami-0b5eea76982371e91"
}

variable "cidr_block" {
    description = "cidr block for vpc"
    type = string
    default = "10.0.0.0/16"
  
}

########### OUTPUT Block ############

output "instance_id" {
  value = aws_instance.test-server.id
  description = "output the instance id of the server"
}

output "public_ip" {
    description = "output the public ip"
    value = aws_instance.test-server.public_ip
  
}