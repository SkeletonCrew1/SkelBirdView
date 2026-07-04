resource "aws_instance" "consul" {
  ami = data.aws_ami.ubuntu.id

  instance_type = var.instance_type

  subnet_id = data.terraform_remote_state.vpc.outputs.public_subnet_b

  associate_public_ip_address = true

  key_name = var.key_name

  vpc_security_group_ids = [
    aws_security_group.consul-sg.id
  ]

  tags = {
    Name      = "Consul-Server"
    ManagedBy = "Terraform"
  }
}