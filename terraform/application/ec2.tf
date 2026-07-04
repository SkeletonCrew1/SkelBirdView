# Load Balancer
resource "aws_instance" "load-balancer" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  subnet_id = data.terraform_remote_state.vpc.outputs.public_subnet_b

  associate_public_ip_address = true

  key_name = data.terraform_remote_state.keys.outputs.key_name

  vpc_security_group_ids = [
    aws_security_group.lb-sg.id
  ]

  tags = {
    Name      = "Load-Balancer"
    ManagedBy = "Terraform"
  }
}

# Web Servers
resource "aws_instance" "web" {
  count = 2

  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  subnet_id = [
    data.terraform_remote_state.vpc.outputs.private_subnet_a,
    data.terraform_remote_state.vpc.outputs.private_subnet_b
  ][count.index]

  associate_public_ip_address = false

  key_name = data.terraform_remote_state.keys.outputs.key_name

  vpc_security_group_ids = [
    aws_security_group.web-sg.id
  ]

  tags = {
    Name      = "web-${count.index}"
    ManagedBy = "Terraform"
  }
}

# Database
resource "aws_instance" "database" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "c7i-flex.large"

  subnet_id = data.terraform_remote_state.vpc.outputs.private_subnet_a

  associate_public_ip_address = false

  key_name = data.terraform_remote_state.keys.outputs.key_name

  vpc_security_group_ids = [
    aws_security_group.database-sg.id
  ]

  tags = {
    Name      = "Database-Server"
    ManagedBy = "Terraform"
  }
}