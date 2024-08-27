locals {
  # Define common tags
  common_tags = merge({
    Environment = var.environment
    Project     = var.project_name
  }, var.additional_tags)
}

# Create a VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = merge(local.common_tags, {
    Name = var.vpc_name
  })
}

# Create a public subnet
resource "aws_subnet" "public" {
  for_each                = { for idx, cidr in var.public_subnet_cidrs : idx => cidr }
  cidr_block              = each.value
  availability_zone       = var.availability_zones[each.key]
  vpc_id                  = aws_vpc.main.id
  map_public_ip_on_launch = true

  tags = merge(local.common_tags, {
    Name = "${var.public_subnet_name}-${each.key + 1}"
  })
}

# Create a private subnet
resource "aws_subnet" "private" {
  for_each          = { for idx, cidr in var.private_subnet_cidrs : idx => cidr }
  cidr_block        = each.value
  availability_zone = var.availability_zones[each.key]
  vpc_id            = aws_vpc.main.id

  tags = merge(local.common_tags, {
    Name = "${var.private_subnet_name}-${each.key + 1}"
  })
}

# Create an Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = merge(local.common_tags, {
    Name = var.igw_name
  })
}

# Create a route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = merge(local.common_tags, {
    Name = var.public_route_table_name
  })
}

# Associate the route table with the public subnet
resource "aws_route_table_association" "a" {
  for_each       = aws_subnet.public
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

# Security Groups
resource "aws_security_group" "assestment_infra_sg" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, {
    Name = var.security_group_name
  })
}
