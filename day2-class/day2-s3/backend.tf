terraform {
  backend "s3" {
    bucket = "minfy-training-abhishek-s3-987"
    key    = "terraform.tfstate"
    region = "ap-south-1"
  }
}