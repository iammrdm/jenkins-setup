locals {
    alb_tg_name = "assestment-infra-app-tg"
    alb_name = "assestment-infra-app-alb"  
    
    # Define common tags
  common_tags = {
    Environment = "assestment"
    Project     = "assestment-infra-vpc"
  }
}

# Create a target group for the ALB
resource "aws_lb_target_group" "assestment_infra_app_tg" {
  name     = local.alb_tg_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.terraform_remote_state.assestment_infra_vpc.outputs.vpc_id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
    matcher             = "200-299"
  }
}

# Create the ALB
resource "aws_lb" "assestment_infra_app_alb" {
  name               = local.alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [data.terraform_remote_state.assestment_infra_sg.outputs.assestment_infra_sg_alb_id]
  subnets            = data.terraform_remote_state.assestment_infra_vpc.outputs.public_subnet_id

  enable_deletion_protection = false

  tags = merge(local.common_tags, {
    Name = local.alb_name
  })
}

# Create an ALB listener
resource "aws_lb_listener" "app_listener" {
  load_balancer_arn = aws_lb.assestment_infra_app_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.assestment_infra_app_tg.arn
  }
}
