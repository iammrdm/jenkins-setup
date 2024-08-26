# Output the bucket name
output "bucket_name" {
  value = aws_s3_bucket.assestment_infra_s3.bucket
}