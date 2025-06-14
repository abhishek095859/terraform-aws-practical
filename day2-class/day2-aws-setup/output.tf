output "website_url" {
  value       = "http://${aws_instance.day-two-abhishek.public_ip}"
  description = "Open this in your browser to see 'Hello World'"
}