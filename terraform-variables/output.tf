# output "dan-s3-bucket-website-domain" {
#   value = aws_s3_bucket.dan-variables-day-s3-bucket.bucket_domain_name
# }

# output "s3-id" {
#   value = aws_s3_bucket.dan-variables-day-s3-bucket.id
# }

output "ec2-public-ip" {
  value = aws_instance.Dan-aws-ec2-instance.private_ip
}