variable "alb_tg_name" {
  description = "The name of the target group"
  type        = string
}

variable "alb_name" {
  description = "The name of the Application Load Balancer"
  type        = string
}

variable "alb_security_group_name" {
  description = "The name of the security group for the ALB"
  type        = string
}

variable "common_tags" {
  description = "Common tags to be applied to the resources"
  type        = map(string)
}

variable "vpc_id" {
  description = "The VPC ID where the ALB will be deployed"
  type        = string
}

variable "subnets" {
  description = "Subnets in which the ALB will be deployed"
  type        = list(string)
}
