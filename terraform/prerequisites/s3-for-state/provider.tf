terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=6.52.0"
    }
  }
# First I created a bucket and backend was local, as soon as the bucket was created I changed backend to use
# s3 bucket and ran "terraform init -migrate-state" to copy local tfstate to s3 bucket
  backend "s3" {
    bucket = "skeleton-crew-terraform-state-s3-bucket"
    key = "state/s3-for-state/terraform.tfstate"
    use_lockfile = true
    region = "us-east-1"
    encrypt = true
  }
}

provider "aws" {
  region = "us-east-1"
}