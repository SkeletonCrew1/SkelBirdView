resource "aws_instance" "jenkins" {
  ami = data.aws_ami.golden-image.id

  instance_type = var.instance_type

  subnet_id = data.terraform_remote_state.vpc.outputs.public_subnet_a

  associate_public_ip_address = true

  iam_instance_profile = data.terraform_remote_state.roles.outputs.jenkins-profile-name

  vpc_security_group_ids = [
    aws_security_group.jenkins-sg.id
  ]

  tags = {
    Name      = "Jenkins-Server"
    ManagedBy = "Terraform"
  }
}