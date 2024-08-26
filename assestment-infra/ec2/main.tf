locals {

  ec2_instance_name = "assestment-infra-ec2"
  ec2_key           = "laboratory_dev" # Replace with your key pair name | Make sure the key pair is existing

  # Define common tags
  common_tags = {
    Environment = "assestment"
    Project     = "assestment-infra-vpc"
  }
}

# Create an EC2 instance with specific storage size
resource "aws_instance" "assestment_infra_ec2_instance" {
  ami                         = "ami-012c2e8e24e2ae21d" # Replace with your desired AMI ID
  instance_type               = "t2.micro"
  subnet_id                   = data.terraform_remote_state.assestment_infra_vpc.outputs.public_subnet_id
  security_groups             = [data.terraform_remote_state.assestment_infra_sg.outputs.assestment_infra_sg_id]
  associate_public_ip_address = true

  root_block_device {
    volume_size = 10    # Specify the desired storage size in GB
    volume_type = "gp2" # General Purpose SSD
  }

  tags = merge(local.common_tags, {
    Name = local.ec2_instance_name
  })

  key_name = local.ec2_key
}