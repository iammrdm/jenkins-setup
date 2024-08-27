# VPC
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = module.vpc.vpc_cidr_block
}

output "public_subnet_ids" {
  description = "A list of IDs of the public subnets"
  value       = module.vpc.public_subnet_ids
}

output "public_subnet_cidrs" {
  description = "A list of CIDR blocks of the public subnets"
  value       = module.vpc.public_subnet_cidrs
}

output "private_subnet_ids" {
  description = "A list of IDs of the private subnets"
  value       = module.vpc.private_subnet_ids
}

output "private_subnet_cidrs" {
  description = "A list of CIDR blocks of the private subnets"
  value       = module.vpc.private_subnet_cidrs
}

output "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  value       = module.vpc.internet_gateway_id
}

output "public_route_table_id" {
  description = "The ID of the public route table"
  value       = module.vpc.public_route_table_id
}

output "security_group_id" {
  value = module.vpc.security_group_id
}

# S3 Bucket Name
output "s3_bucket_name" {
  description = "The name of the S3 bucket"
  value       = module.s3_bucket.bucket_name
}

# EC2
output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = module.ec2.instance_id
}

# ALB
output "alb_arn" {
  description = "The ARN of the Application Load Balancer"
  value       = module.alb.alb_arn
}

output "target_group_arn" {
  description = "The ARN of the target group"
  value       = module.alb.target_group_arn
}

output "listener_arn" {
  description = "The ARN of the listener"
  value       = module.alb.listener_arn
}

output "alb_security_group_id" {
  description = "The ID of the ALB security group"
  value       = module.alb.alb_security_group_id
}

