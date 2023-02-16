
#########################################################
# VARIABLE FOR VPC & SUBNET
#########################################################
variable "region" {
  description = "passing the region"
  type        = string
  default     = "us-east-1"
}

variable "component" {
  description = "passing the component"
  type        = string
  default     = "3-tier-architecture"
}

variable "vpc_cidr" {
  description = "passing the cidr block for the vpc"
  type        = string
}

variable "public_subnet_cidr" {
  description = "passing the cidr for the public subnet"
  type        = list(any)

}

variable "backend_subnet_cidr" {
  description = "passing the cidr for the backend subnet"
  type        = list(any)

}

variable "database_subnet_cidr" {
  description = "passing the cidr for the database subnet"
  type        = list(any)

}

variable "instance_type" {
  description = "passing instance type"
  type        = string
}

#########################################################
# VARIABLE FOR DATABASE
#########################################################

variable "username" {
  type        = string
  description = "db username"
}

variable "port" {
  type        = number
  description = "db port number"
  default     = 3306
}

variable "db_name" {
  type        = string
  description = "db name"
  default     = "webappdb"
}

variable "instance_class" {
  type        = string
  description = "db instance class"

}

#########################################################
# VARIABLE FOR DNS
#########################################################

variable "dns_name" {
  type        = string
  description = "vaue of our dns name"

}

variable "subject_alternative_names" {
  type        = list(any)
  description = "passing the subject alternative domain names"

}
