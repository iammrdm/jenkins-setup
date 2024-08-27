locals {
    alb_tg_name           = var.alb_tg_name
    alb_name              = var.alb_name
    alb_security_group_name = var.alb_security_group_name

    # Define common tags
    common_tags = var.common_tags
}

# Define a security group for the ALB
resource "aws_security_group" "this" {
  name        = local.alb_security_group_name
  description = "Allow HTTP and HTTPS traffic and default SG for ALB"
  vpc_id      = var.vpc_id

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

# Create a target group for the ALB
resource "aws_lb_target_group" "this" {
  name     = local.alb_tg_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

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
resource "aws_lb" "this" {
  name               = local.alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.this.id]
  subnets            = var.subnets

  enable_deletion_protection = false

  tags = merge(local.common_tags, {
    Name = local.alb_name
  })
}

# Create an ALB listener
resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}
