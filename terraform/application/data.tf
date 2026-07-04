data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = var.vpc_state_bucket
    key    = var.vpc_state_key
    region = var.state_region
  }
}

data "terraform_remote_state" "jenkins" {
  backend = "s3"

  config = {
    bucket = var.jenkins_state_bucket
    key    = var.jenkins_state_key
    region = var.state_region
  }
}

data "terraform_remote_state" "consul" {
  backend = "s3"

  config = {
    bucket = var.consul_state_bucket
    key    = var.consul_state_key
    region = var.state_region
  }
}

data "terraform_remote_state" "keys" {
  backend = "s3"

  config = {
    bucket = var.keys_state_bucket
    key    = var.keys_state_key
    region = var.state_region
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  owners = ["099720109477"]

  filter {
    name = "name"

    values = [
      "ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"
    ]
  }

  filter {
    name = "virtualization-type"

    values = ["hvm"]
  }
}