data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = var.vpc_state_bucket
    key    = var.vpc_state_key
    region = var.vpc_state_region
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  owners = [
    "099720109477"
  ]

  filter {
    name = "name"

    values = [
      "ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"
    ]
  }

  filter {
    name = "virtualization-type"

    values = [
      "hvm"
    ]
  }
}