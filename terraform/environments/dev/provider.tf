terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 6.52.0"
    }
  }

  backend "s3" {
    bucket = "birdwatching-state-bucket"
    key = "dev/application.tfstate"
    region = "eu-north-1"
    encrypt = true
    use_lockfile = true
  }
}