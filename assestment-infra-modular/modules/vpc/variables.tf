variable "vpc_cidr" {
  type        = string
  description = "The CIDR block for the VPC"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "A list of CIDR blocks for the public subnets"
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "A list of CIDR blocks for the private subnets"
}

variable "availability_zones" {
  type        = list(string)
  description = "A list of availability zones to use for the subnets"
}

variable "vpc_name" {
  type        = string
  description = "The name for the VPC"
}

variable "public_subnet_name" {
  type        = string
  description = "The base name for the public subnets"
}

variable "private_subnet_name" {
  type        = string
  description = "The base name for the private subnets"
}

variable "igw_name" {
  type        = string
  description = "The name for the Internet Gateway"
}

variable "public_route_table_name" {
  type        = string
  description = "The name for the public route table"
}

variable "environment" {
  type        = string
  description = "The environment name (e.g., dev, prod)"
}

variable "project_name" {
  type        = string
  description = "The name of the project"
}

variable "additional_tags" {
  type        = map(string)
  description = "Additional tags to apply to all resources"
  default     = {}
}

variable "security_group_name" {
  description = "Name of the security group"
  type        = string
}
