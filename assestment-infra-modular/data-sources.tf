data "terraform_remote_state" "assestment_infra_vpc" {
  backend = "s3"

  config = {
    bucket = "oh-terraform"
    key    = "assetment-infra/lm/assestment-infra-vpc.tfstate"
    region = "ap-southeast-1"
  }
}
