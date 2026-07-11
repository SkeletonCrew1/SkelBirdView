terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 6.52.0"
    }
  }

  backend "s3" {
    bucket = "skeleton-crew-terraform-state-s3-bucket"
    key = "dev-infra/application.tfstate"
    region = "us-east-1"
    encrypt = true
    use_lockfile = true
  }
}