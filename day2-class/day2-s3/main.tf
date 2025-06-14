terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
provider "aws" {
  region = "us-east-1"
  profile = ""
}

resource "aws_s3_bucket" "abhishek_s3_bucket" {
  bucket = "minfy-training-abhishek-s3-987"
}