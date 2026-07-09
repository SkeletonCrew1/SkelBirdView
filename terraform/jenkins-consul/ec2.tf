resource "aws_instance" "jenkins" {
  ami = data.aws_ami.golden-image.id

  instance_type = var.instance_type

  subnet_id = data.terraform_remote_state.vpc.outputs.private_subnet_a

  iam_instance_profile = data.terraform_remote_state.roles.outputs.jenkins-profile-name

  vpc_security_group_ids = [
    aws_security_group.jenkins-sg.id
  ]

  root_block_device {
    volume_size = 75
    volume_type = "gp3"
    encrypted = true
    delete_on_termination = true
  }

  tags = {
    Name      = "Jenkins-Server"
    ManagedBy = "Terraform"
  }
}

resource "aws_instance" "consul" {
  ami = data.aws_ami.golden-image.id

  instance_type = "t3.small"

  subnet_id = data.terraform_remote_state.vpc.outputs.private_subnet_b

  iam_instance_profile = data.terraform_remote_state.roles.outputs.consul-profile-name

  vpc_security_group_ids = [
    aws_security_group.consul-sg.id
  ]

  tags = {
    Name      = "Consul-Server"
    ManagedBy = "Terraform"
  }
}
