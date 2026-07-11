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