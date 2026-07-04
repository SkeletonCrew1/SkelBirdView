resource "aws_security_group" "jenkins-sg" {
  name   = "jenkins-sg"
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "jenkins-http" {
  security_group_id = aws_security_group.jenkins-sg.id

  cidr_ipv4 = "0.0.0.0/0"

  from_port = 8080
  to_port   = 8080

  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "jenkins-ssh" {
  security_group_id = aws_security_group.jenkins-sg.id

  cidr_ipv4 = "0.0.0.0/0"

  from_port = 22
  to_port   = 22

  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "jenkins-egress" {
  security_group_id = aws_security_group.jenkins-sg.id

  cidr_ipv4 = "0.0.0.0/0"

  ip_protocol = "-1"
}