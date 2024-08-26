output "assestment_infra_sg_id" {
  value = aws_security_group.assestment_infra_sg.id
}

output "assestment_infra_sg_alb_id" {
    value = aws_security_group.assestment_infra_alb_sg.id
}