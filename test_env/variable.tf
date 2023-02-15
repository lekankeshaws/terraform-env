

#########################################################
# VARIABLE BLOCK
#########################################################

variable "vpc_cidr" {
  type        = string
  description = "calling vpc cidr"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  type        = list(any)
  description = "calling public subnet cidr block"
  default     = ["10.0.0.0/24", "10.0.2.0/24", "10.0.4.0/24"]

}

variable "private_subnet_cidr" {
  type        = list(any)
  description = "calling private subnet cidr block"
  default     = ["10.0.1.0/24", "10.0.3.0/24", "10.0.5.0/24"]

}

variable "region" {
  type        = string
  description = "calling region"
  default     = "us-east-1"

}