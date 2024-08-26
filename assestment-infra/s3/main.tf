locals {
  s3_bucket_name = "assestment-infra-s3"
  # Define common tags
  common_tags = {
    Environment = "assestment"
    Project     = "assestment-infra-vpc"
  }
}

resource "aws_s3_bucket" "assestment_infra_s3" {
  bucket = local.s3_bucket_name

  tags = merge(local.common_tags, {
    Name = local.s3_bucket_name
  })
}