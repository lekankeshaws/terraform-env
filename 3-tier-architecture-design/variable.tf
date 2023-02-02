

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
