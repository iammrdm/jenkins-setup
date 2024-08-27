variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "common_tags" {
  description = "Common tags to apply to the resource"
  type        = map(string)
}
