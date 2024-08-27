
resource "aws_instance" "this" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_ids[0]  # Only the first subnet ID used for now
  security_groups             = [var.security_group_id]
  associate_public_ip_address = true

  root_block_device {
    volume_size = 10    # Specify the desired storage size in GB
    volume_type = "gp2" # General Purpose SSD
  }

  tags = var.tags

  key_name = var.key_name
}