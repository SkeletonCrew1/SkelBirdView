# Load Balancer
resource "aws_instance" "load-balancer" {
  ami           = data.aws_ami.golden-image.id
  instance_type = "t3.micro"

  subnet_id = data.terraform_remote_state.vpc.outputs.public_subnet_b

  associate_public_ip_address = true

  iam_instance_profile = data.terraform_remote_state.roles.outputs.ssm-profile-name

  vpc_security_group_ids = [
    aws_security_group.lb-sg.id
  ]

  tags = {
    Name      = "Load-Balancer-Server"
    ManagedBy = "Terraform"
  }
}

# Web Servers
resource "aws_instance" "web" {
  count = 2

  ami           = data.aws_ami.golden-image.id
  instance_type = "t3.micro"

  subnet_id = [
    data.terraform_remote_state.vpc.outputs.private_subnet_a,
    data.terraform_remote_state.vpc.outputs.private_subnet_b
  ][count.index]

  associate_public_ip_address = false

  iam_instance_profile = data.terraform_remote_state.roles.outputs.ssm-profile-name

  vpc_security_group_ids = [
    aws_security_group.web-sg.id
  ]

  tags = {
    Name      = "Web-Server-${count.index}"
    ManagedBy = "Terraform"
  }
}

# Database
resource "aws_instance" "database" {
  ami           = data.aws_ami.golden-image.id
  instance_type = "c7i-flex.large"

  subnet_id = data.terraform_remote_state.vpc.outputs.private_subnet_a

  associate_public_ip_address = false

  iam_instance_profile = data.terraform_remote_state.roles.outputs.ssm-profile-name

  vpc_security_group_ids = [
    aws_security_group.database-sg.id
  ]

  tags = {
    Name      = "Database-Server"
    ManagedBy = "Terraform"
  }
}
