output "website_endpoint" {
  description = "The URL of the static website hosted on S3"
  value       = aws_s3_bucket_website_configuration.abhishek7.website_endpoint
}
