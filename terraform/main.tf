terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.64.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}
resource "aws_s3_bucket" "test" {
  bucket = "test-terraform"
}
resource "aws_s3_object" "object_site1" {
  for_each = fileset("site/", "*")
  bucket   = aws_s3_bucket.test.id
  key      = each.value
  source   = "site/${each.value}"
}
