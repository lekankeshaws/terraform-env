

############ Variable Block ##############

# variable "ami_id" {
#   type        = string
#   description = "ami id"
#   default     = "ami-0b5eea76982371e91"
# }

variable "vpc_cidr" {
  description = "cidr block for vpc & subnet"
  type        = string
  default     = "10.0.0.0/16"

}

variable "public_subnet_cidr" {
  description = "private ip cidr"
  type        = list(any)
  default     = ["10.0.0.0/24", "10.0.1.0/24"]

}

variable "private_subnet_cidr" {
  description = "private ip cidr"
  type        = list(any)
  default     = ["10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24" ]

}

variable "aws_region" {
  description = "used to define region"
  default     = "us-east-1"

}

variable "ami_list" {
  description = "used to call AMI's"
  type        = list(string)
  default     = ["data.aws_ami.ami_amazon.id", "data.aws_ami.ami_redhat.id"]

}