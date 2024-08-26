data "terraform_remote_state" "assestment_infra_vpc" {
  backend = "s3"

  config = {
    bucket = "oh-terraform"
    key    = "assetment-infra/vpc/assestment-infra-vpc.tfstate"
    region = "ap-southeast-1"
  }
}

data "terraform_remote_state" "assestment_infra_sg" {
  backend = "s3"

  config = {
    bucket = "oh-terraform"
    key    = "assetment-infra/sg/assestment-infra-sg.tfstate"
    region = "ap-southeast-1"
  }

}
