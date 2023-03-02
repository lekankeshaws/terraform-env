
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

resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
  count = length(var.bucket_name)
  bucket = aws_s3_bucket.bucket[count.index].id
  policy = data.aws_iam_policy_document.allow_access_from_another_account[count.index].json
}

data "aws_iam_policy_document" "allow_access_from_another_account" {
  count = length(var.bucket_name)
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = var.account_role_arns
    }

    actions = [
      "s3:GetObject",
      "s3:ListBucket",
      "s3:PutObject",
      "s3:DeleteObject",
    ]

    resources = [
      aws_s3_bucket.bucket[count.index].arn,
      join("/", [aws_s3_bucket.bucket[count.index].arn, "*"]),
    ]
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