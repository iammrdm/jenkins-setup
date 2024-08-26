locals {
  # Define common CIDR blocks
  vpc_cidr            = "10.0.0.0/16"
  public_subnet_cidr  = "10.0.1.0/24"
  private_subnet_cidr = "10.0.2.0/24"

  # Define common names
  vpc_name                = "assestment-infra"
  public_subnet_name      = "public-subnet"
  private_subnet_name     = "private-subnet"
  igw_name                = "assestment-infra-igw"
  public_route_table_name = "assestment-infra-public-route-table"
  
  # Define common tags
  common_tags = {
    Environment = "assestment"
    Project     = "assestment-infra-vpc"
  }

}

# Create a VPC
resource "aws_vpc" "main" {
  cidr_block = local.vpc_cidr

  tags = merge(local.common_tags, {
    Name = local.vpc_name
  })
}

# Create a public subnet
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = local.public_subnet_cidr
  map_public_ip_on_launch = true

  tags = merge(local.common_tags, {
    Name = local.public_subnet_name
  })
}

# Create a private subnet
resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.main.id
  cidr_block = local.private_subnet_cidr

  tags = merge(local.common_tags, {
    Name = local.private_subnet_name
  })
}

# Create an Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = merge(local.common_tags, {
    Name = local.igw_name
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
    Name = local.public_route_table_name
  })
}

# Associate the route table with the public subnet
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}