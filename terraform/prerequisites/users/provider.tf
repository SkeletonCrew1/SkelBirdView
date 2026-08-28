terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=6.52.0"
    }
  }

  backend "s3" {
    bucket       = "birdwatching-terraform-state-s3-bucket"
    key          = "state/users/terraform.tfstate"
    use_lockfile = true
    region       = "eu-north-1"
    encrypt      = true
  }
}

provider "aws" {
  region = "eu-north-1"
}
