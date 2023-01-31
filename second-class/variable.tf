variable "aws_region" {
  description = "used to define region"
  default     = "us-east-1"

}

variable "private_ips" {
  description = "range of ip addresses for the private subnets"
  type        = list(any)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]

}

variable "public_ips" {
  description = "list of ip for the public subnets"
  type        = list(any)
  default     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

}

variable "vpc_cidr" {
  description = "ip address cidr block for the vpc"
  type        = string
  default     = "10.0.0.0/16"

}