data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = var.vpc_state_bucket
    key    = var.vpc_state_key
    region = var.state_region
  }
}

data "terraform_remote_state" "jenkins-consul" {
  backend = "s3"

  config = {
    bucket = var.jenkins_consul_state_bucket
    key    = var.jenkins_consul_state_key
    region = var.state_region
  }
}

data "terraform_remote_state" "roles" {
  backend = "s3"

  config = {
    bucket = var.roles_state_bucket
    key = var.roles_state_key
    region = var.state_region
  }
}

data "aws_ami" "golden-image" {
  most_recent = true

  owners = [
    "self"
  ]

  filter {
    name = "name"

    values = [
      "ubuntu26-golden-image-*"
    ]
  }

  filter {
    name = "virtualization-type"

    values = [
      "hvm"
    ]
  }
}