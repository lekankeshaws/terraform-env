
########## VARIABLE BLOCK ###########
variable "vpc_cidr" {
  description = "calling the vpc cidr"
  type        = string
  default     = "10.0.0.0/16"
}

variable "aws_region" {
  description = "calling the region for the provider block"
  type        = string
  default     = "us-east-1"
}

variable "cidr_block_ssh" {
  description = "to pass the ip for ssh ingress"
  type        = string
  default     = "0.0.0.0/0"

}