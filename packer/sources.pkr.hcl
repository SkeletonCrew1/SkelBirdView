source "amazon-ebs" "ubuntu26-golden-image" {
  access_key        = "${var.access_key}"
  secret_key        = "${var.secret_key}"
  ssh_username      = "${var.ssh_username}"
  region            = "${var.region}"
  vpc_id            = "${var.vpc_id}"
  subnet_id         = "${var.subnet_id}"
  security_group_id = "${var.security_group_id}"
  ami_name          = "${var.ami_name}"
  source_ami        = "${var.source_ami}"
  instance_type     = "${var.instance_type}"
}
