# Load Balancer
resource "aws_security_group" "lb-sg" {
  name   = "lb-sg"
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "lb-http" {
  security_group_id = aws_security_group.lb-sg.id

  cidr_ipv4 = "0.0.0.0/0"

  from_port = 80
  to_port   = 80

  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "lb-ssh" {
  security_group_id = aws_security_group.lb-sg.id

  referenced_security_group_id = data.terraform_remote_state.jenkins.outputs.jenkins_security_group_id

  from_port = 22
  to_port   = 22

  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "lb-egress" {
  security_group_id = aws_security_group.lb-sg.id

  cidr_ipv4 = "0.0.0.0/0"

  ip_protocol = "-1"
}

# Web Servers
resource "aws_security_group" "web-sg" {
  name   = "web-sg"
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "web-http" {
  security_group_id = aws_security_group.web-sg.id

  referenced_security_group_id = aws_security_group.lb-sg.id

  from_port = 80
  to_port   = 80

  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "web-ssh" {
  security_group_id = aws_security_group.web-sg.id

  referenced_security_group_id = data.terraform_remote_state.jenkins.outputs.jenkins_security_group_id

  from_port = 22
  to_port   = 22

  ip_protocol = "tcp"
}

# Consul communication
resource "aws_vpc_security_group_ingress_rule" "web-consul" {
  security_group_id = aws_security_group.web-sg.id

  referenced_security_group_id = data.terraform_remote_state.consul.outputs.consul_security_group_id

  from_port = 8500
  to_port   = 8500

  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "web-egress" {
  security_group_id = aws_security_group.web-sg.id

  cidr_ipv4 = "0.0.0.0/0"

  ip_protocol = "-1"
}

# Database
resource "aws_security_group" "database-sg" {
  name   = "database-sg"
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "database-mysql" {
  security_group_id = aws_security_group.database-sg.id

  referenced_security_group_id = aws_security_group.web-sg.id

  from_port = 3306
  to_port   = 3306

  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "database-ssh" {
  security_group_id = aws_security_group.database-sg.id

  referenced_security_group_id = data.terraform_remote_state.jenkins.outputs.jenkins_security_group_id

  from_port = 22
  to_port   = 22

  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "database-egress" {
  security_group_id = aws_security_group.database-sg.id

  cidr_ipv4 = "0.0.0.0/0"

  ip_protocol = "-1"
}