# Create s3 bucket
resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name

  tags = merge(var.common_tags, {
    Name = var.bucket_name
  })
}
