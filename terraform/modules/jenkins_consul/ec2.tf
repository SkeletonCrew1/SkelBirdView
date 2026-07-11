resource "aws_instance" "jenkins" {
  ami = var.jenkins_ami

  instance_type = var.jenkins_instance_type

  subnet_id = var.jenkins_subnet_id

  iam_instance_profile = aws_iam_instance_profile.jenkins-profile.id

  vpc_security_group_ids = [
    aws_security_group.jenkins-sg.id
  ]

  root_block_device {
    volume_size = var.jenkins_disk_size
    volume_type = "gp3"
    encrypted = true
    delete_on_termination = true
  }

  tags = {
    Name      = var.jenkins_name
    ManagedBy = "Terraform"
  }
}

resource "aws_instance" "consul" {
  ami = var.consul_ami

  instance_type = var.consul_instance_type

  subnet_id = var.consul_subnet_id

  iam_instance_profile = aws_iam_instance_profile.consul-profile.id

  vpc_security_group_ids = [
    aws_security_group.consul-sg.id
  ]

  tags = {
    Name      = var.consul_name
    ManagedBy = "Terraform"
  }
}
