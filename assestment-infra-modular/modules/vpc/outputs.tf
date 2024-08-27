output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = aws_vpc.main.cidr_block
}

output "public_subnet_ids" {
  description = "A list of IDs of the public subnets"
  value       = [for subnet in aws_subnet.public : subnet.id]
}

output "public_subnet_cidrs" {
  description = "A list of CIDR blocks of the public subnets"
  value       = [for subnet in aws_subnet.public : subnet.cidr_block]
}

output "private_subnet_ids" {
  description = "A list of IDs of the private subnets"
  value       = [for subnet in aws_subnet.private : subnet.id]
}

output "private_subnet_cidrs" {
  description = "A list of CIDR blocks of the private subnets"
  value       = [for subnet in aws_subnet.private : subnet.cidr_block]
}

output "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  value       = aws_internet_gateway.gw.id
}

output "public_route_table_id" {
  description = "The ID of the public route table"
  value       = aws_route_table.public.id
}

output "security_group_id" {
  value = aws_security_group.assestment_infra_sg.id
}