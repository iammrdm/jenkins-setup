locals {
  common_tags = {
    Environment = "assestment"
    Project     = "assestment-infra-vpc"
  }
}

module "vpc" {
  source = "./modules/vpc"

  vpc_cidr                = "10.0.0.0/16"
  public_subnet_cidrs     = ["10.0.1.0/24", "10.0.3.0/24"]
  private_subnet_cidrs    = ["10.0.2.0/24", "10.0.4.0/24"]
  availability_zones      = ["ap-southeast-1a", "ap-southeast-1b"]
  vpc_name                = "assessment-infra"
  public_subnet_name      = "public-subnet"
  private_subnet_name     = "private-subnet"
  igw_name                = "assessment-infra-igw"
  public_route_table_name = "assessment-infra-public-route-table"
  environment             = "assessment"
  project_name            = "assessment-infra-vpc"
  security_group_name     = "assestment-infra-sg"
  additional_tags = {
    Owner = "iammrdm"
  }
}

module "s3_bucket" {
  source      = "./modules/s3_bucket"
  bucket_name = "assestment-infra-s3"
  common_tags = local.common_tags
}

module "ec2" {
  source            = "./modules/ec2"
  ami               = "ami-012c2e8e24e2ae21d" # Replace with your desired AMI ID
  instance_type     = "t2.micro"
    subnet_ids = module.vpc.public_subnet_ids
    security_group_id =  module.vpc.security_group_id
  key_name          = "laboratory_dev"
  tags = merge(local.common_tags, {
    Name = "assestment-infra-ec2"
  })
  depends_on = [module.vpc]
}

module "alb" {
  source = "./modules/alb"

  alb_tg_name             = "assestment-infra-app-tg"
  alb_name                = "assestment-infra-app-alb"
  alb_security_group_name = "assestment-infra-alb-sg"
  common_tags             = local.common_tags
vpc_id =  module.vpc.vpc_id
subnets =  module.vpc.public_subnet_ids
  depends_on = [module.vpc]
}
