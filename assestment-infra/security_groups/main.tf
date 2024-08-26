

locals {
    
  security_group_name     = "assestment-infra-sg"
  alb_security_group_name = "assestment-infra-sg-alb"
  
  # Define common tags
  common_tags = {
    Environment = "assestment"
    Project     = "assestment-infra-vpc"
  }
}

# Create a security group
resource "aws_security_group" "assestment_infra_sg" {
  vpc_id = data.terraform_remote_state.assestment_infra_vpc.outputs.vpc_id
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
    Name = local.security_group_name
  })
}

# Define a security group for the ALB
resource "aws_security_group" "assestment_infra_alb_sg" {
  name        = local.alb_security_group_name
  description = "Allow HTTP and HTTPS traffic and default SG for ALB"
  vpc_id = data.terraform_remote_state.assestment_infra_vpc.outputs.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
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
    Name = local.alb_security_group_name
  })
}