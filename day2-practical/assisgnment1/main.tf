provider "aws" {
 region = "ap-south-1"
 profile = "AdminAccess-602151476946"
}

resource "aws_s3_bucket" "abhishek7" {
  bucket = "minfy-abhishek7"

  tags = {
    Name        = "abhishek7-12"
  }
}

resource "aws_s3_bucket_public_access_block" "abhishek7" {
  bucket = aws_s3_bucket.abhishek7.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_website_configuration" "abhishek7" {
  bucket = aws_s3_bucket.abhishek7.id

  index_document {
    suffix = "index.html"
  }
}

data "aws_iam_policy_document" "public_read" {
  statement {
    sid       = "PublicReadGetObject"
    effect    = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject"
    ]

    resources = [
      "${aws_s3_bucket.abhishek7.arn}/*"
    ]
  }
}
resource "aws_s3_bucket_policy" "public_read_policy" {
  bucket = aws_s3_bucket.abhishek7.id
  policy = data.aws_iam_policy_document.public_read.json
}

resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.abhishek7.bucket
  key          = "index.html"
  source       = "index.html" 
  content_type = "text/html" 
}


