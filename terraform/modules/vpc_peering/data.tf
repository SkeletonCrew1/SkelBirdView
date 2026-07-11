data "terraform_remote_state" "jenikns-vpc" {
  backend = "s3"

  config = {
    bucket = "skeleton-crew-terraform-state-s3-bucket"
    key    = "state/vpc-infrastructure/terraform.tfstate"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "test-vpc" {
  backend = "s3"

  config = {
    bucket = "skeleton-crew-terraform-state-s3-bucket"
    key    = "dev/networking.tfstate"
    region = "us-east-1"
  }
}