data "terraform_remote_state" "dev_infra" {
  backend = "s3"

  config = {
    bucket = var.dev_infra_bucket
    key    = var.dev_infra_key
    region = var.region
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

data "aws_route53_zone" "birdwatching" {
  name         = "birdview.pp.ua"
  private_zone = false
}