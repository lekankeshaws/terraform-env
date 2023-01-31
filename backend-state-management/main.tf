
#########################################################
# Terraform block
#########################################################
terraform {
  required_version = ">=1.1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

#########################################################
# RESOURCE BLOCK
#########################################################
resource "aws_s3_bucket" "bucket" {
  count  = length(var.bucket_name)
  bucket = "${var.bucket_name[count.index]}-lekan-kesh-buck"

  tags = {
    name = "bucket_${count.index + 1}"
  }

}

resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name = "terraform-lock"

  read_capacity  = 20
  write_capacity = 20
  hash_key       = "LockID"


  attribute {
    name = "LockID"
    type = "S"
  }

  lifecycle {
    prevent_destroy = true
  }

}