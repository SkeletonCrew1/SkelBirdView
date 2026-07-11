# Load Balancer
resource "aws_instance" "load-balancer" {
  ami           = var.lb_ami # data.aws_ami.golden-image.id
  instance_type = var.lb_instance_type

  subnet_id = var.lb_subnet_id # data.terraform_remote_state.vpc.outputs.public_subnet_b

  associate_public_ip_address = true

  iam_instance_profile = var.lb_iam_instance_profile # data.terraform_remote_state.roles.outputs.ssm-profile-name

  vpc_security_group_ids = [
    aws_security_group.lb-sg.id
  ]

  tags = {
    Name      = var.lb_name
    ManagedBy = "Terraform"
  }
}

# Web Servers
resource "aws_instance" "web" {
  count = var.web_instances_count

  ami           = var.web_ami # data.aws_ami.golden-image.id
  instance_type = var.web_instance_type

  subnet_id = var.web_subnet_id

  associate_public_ip_address = false

  iam_instance_profile = var.web_iam_instance_profile # data.terraform_remote_state.roles.outputs.ssm-profile-name

  vpc_security_group_ids = [
    aws_security_group.web-sg.id
  ]

  tags = {
    Name      = "${var.web_name}-${count.index}"
    ManagedBy = "Terraform"
  }
}

# Database
resource "aws_instance" "database" {
  ami           = var.db_ami # data.aws_ami.golden-image.id
  instance_type = var.db_instance_type # "c7i-flex.large"

  subnet_id = var.db_subnet_id # data.terraform_remote_state.vpc.outputs.private_subnet_a

  associate_public_ip_address = false

  iam_instance_profile = var.db_iam_instance_profile # data.terraform_remote_state.roles.outputs.ssm-profile-name

  vpc_security_group_ids = [
    aws_security_group.database-sg.id
  ]

  tags = {
    Name      = var.db_name
    ManagedBy = "Terraform"
  }
}
