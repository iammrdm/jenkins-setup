variable "ami" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "Type of the EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "subnet_ids" {
  description = "Subnet ID for the EC2 instance"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security group ID for the EC2 instance"
  type        = string
}

variable "key_name" {
  description = "Key name for the EC2 instance"
  type        = string
}

variable "tags" {
  description = "Tags for the EC2 instance"
  type        = map(string)
  default     = {}
}
