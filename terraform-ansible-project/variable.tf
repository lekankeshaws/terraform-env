

#########################################################
# CREATING VARIABLE BLOCK
#########################################################

variable "region" {
  type        = string
  description = "passing the region"
  default     = "us-east-1"
}

variable "profile" {
  type        = string
  description = "passing the profile for aws"
  default     = "iamadmin"
}

variable "env" {
  type        = string
  description = "passing values for tags"
  default     = "sbx"

}

variable "vpc_cidr" {
  type        = string
  description = "passing vpc cidr block"
  default     = "10.0.0.0/16"

}

variable "public_subnet_cidr" {
  type        = string
  description = "passing public subnet cidr"
  default     = "10.0.0.0/24"

}

variable "instance_type" {
  type        = string
  description = "specifying the instance type"
  default     = "t2.micro"

}

variable "key_name" {
  type        = string
  description = "passing user data"
  default     = "mypemkey"

}

variable "ports" {
  type        = list(any)
  description = "passing port numbers"
  default     = [22, "-1", 80]
}

variable "protocol" {
  type        = list(any)
  description = "passing protocols"
  default     = ["tcp", "icmp", "tcp"]

}