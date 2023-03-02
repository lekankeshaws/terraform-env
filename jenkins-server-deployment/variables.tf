


variable "instance_type" {
    type = string
    description = "passing the instance type"
    default = "t2.micro"
  
}

variable "component" {
    type = string
    description = "passing env name"
    default = "automation"
  
}

variable "vpc_cidr" {
    type = string
    description = "passing env name"
    default = "10.0.0.0/16"
  
}

variable "component_name" {
    type = string
    description = "passing env name"
    default = "automation"
  
}

variable "profile" {
    type = string
    description = "passing profile for aws"
    default = "iamadmin"
  
}

variable "region" {
    type = string
    description = "passing profile for aws"
    default = "us-east-1"
  
}

