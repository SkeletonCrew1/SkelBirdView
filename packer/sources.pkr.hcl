source "amazon-ebs" "ubuntu26-golden-image" {
  tags = {
    Name = "Golden-Image"
  }

  run_tags = {
    Name = "Packer-Builder"
  }

  access_key        = "${var.access_key}"
  secret_key        = "${var.secret_key}"
  ssh_username      = "ubuntu"
  region            = "us-east-1"
  vpc_id            = "${var.vpc_id}"
  subnet_id         = "${var.subnet_id}"
  security_group_id = "${var.security_group_id}"

  ami_name          = "ubuntu26-golden-image-${formatdate("DDMMYYHHmm", timestamp())}"
  instance_type     = "t3.small"

  source_ami_filter {
    filters = {
      name = "ubuntu/images/hvm-ssd-gp3/ubuntu-resolute-26.04-amd64-server-*"
    }
    owners      = ["099720109477"] # Canonical Group Limited
    most_recent = true
  }
}
