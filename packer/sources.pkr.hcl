source "amazon-ebs" "ubuntu26-golden-image" {
  tags = {
    Name = "Golden Image"
  }
  run_tags = {
    Name = "Packer Builder"
  }
  access_key        = "${var.access_key}"
  secret_key        = "${var.secret_key}"
  ssh_username      = "ubuntu"
  region            = "us-east-1"
  vpc_id            = "${var.vpc_id}"
  subnet_id         = "${var.subnet_id}"
  security_group_id = "${var.security_group_id}"
  ami_name          = "ubuntu26-golden-image-${formatdate("DDMMYYHHmm", timestamp())}"
  source_ami        = "ami-0b6d9d3d33ba97d99" # Ubuntu Server 26.04 (x86)
  instance_type     = "t3.micro"
}
