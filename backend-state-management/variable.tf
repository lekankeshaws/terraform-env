

#########################################################
# VARIABLE BLOCK
#########################################################
variable "bucket_name" {
  description = "to name bucket"
  type        = list(any)
  default = [
    "backend-0131-",
    "backend-0201",
    "backend-0301",
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

variable "account_role_arns" {
  type = list
  description = "passing arn for bucket policy roles"
  default = [
    "arn:aws:iam::911070830892:role/cross-account-terraform-role",
    "arn:aws:iam::285687660873:role/cross-account-terraform-role",
    "arn:aws:iam::380274938814:role/cross-account-terraform-role",
  ]
}