

#########################################################
# VARIABLE BLOCK
#########################################################
variable "bucket_name" {
  description = "to name bucket"
  type        = list(any)
  default = [
    "backend-0131-",
  ]

}

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