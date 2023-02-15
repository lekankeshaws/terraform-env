
#########################################################
# VARIABLE BLOCK
#########################################################
variable "region" {
  description = "passing the region"
  type        = string
  default     = "us-east-1"

}

variable "aws_profile" {
  description = "to pass profile"
  type        = string
  default     = "iamadmin"

}

variable "vpc_cidr" {
  description = "calling the vpc cidr"
  type        = string
  default     = "10.0.0.0/16"
}

variable "cidr_block_ssh" {
  description = "to pass the ip for ssh ingress"
  type        = string
  default     = "0.0.0.0/0"

}

variable "public_subnet_cidr" {
  type = list
  description = "passing the public subnet cidr"
  default = ["10.0.1.0/24"]
  
}