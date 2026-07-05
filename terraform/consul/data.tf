data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = var.vpc_state_bucket
    key    = var.vpc_state_key
    region = var.vpc_state_region
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
      "ubuntu26-golden-image-0407260325"
    ]
  }

  filter {
    name = "virtualization-type"

    values = [
      "hvm"
    ]
  }
}