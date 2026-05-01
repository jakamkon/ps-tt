terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.42.0"
    }
  }
}

variable "demo_id" {
  description = "Unique demo identifier"
  default = "00"
}

resource "aws_s3_bucket" "user1" {
  bucket = "ps-demo-tf-client-user1-${var.demo_id}"
}

resource "aws_s3_bucket_versioning" "user1" {
  bucket = aws_s3_bucket.user1.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket" "user2" {
  bucket = "ps-demo-tf-client-user2-${var.demo_id}"
}

resource "aws_s3_bucket_versioning" "user2" {
  bucket = aws_s3_bucket.user2.id
  versioning_configuration {
    status = "Enabled"
  }
}
resource "aws_s3_bucket" "user3" {
  bucket = "ps-demo-tf-client-user3-${var.demo_id}"
}

# Same bug is in demo CLI, but this time terraform
# will throw an error
# Comment to disable
resource "aws_s3_bucket_versioning" "user2" {
  bucket = aws_s3_bucket.user2.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Uncomment below to enable versioning for user3
# resource "aws_s3_bucket_versioning" "user3" {
#  bucket = aws_s3_bucket.user3.id
#  versioning_configuration {
#    status = "Enabled"
#  }
# }