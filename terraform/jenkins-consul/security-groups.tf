# Jenkins security group
resource "aws_security_group" "jenkins-sg" {
  name   = "jenkins-sg"
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "jenkins-consul" {
  security_group_id = aws_security_group.jenkins-sg.id

  referenced_security_group_id = aws_security_group.consul-sg.id

  from_port = 8500
  to_port   = 8500

  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "jenkins-consul-port" {
  security_group_id = aws_security_group.jenkins-sg.id

  referenced_security_group_id = aws_security_group.consul-sg.id

  from_port = 8301
  to_port   = 8301

  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "jenkins-egress" {
  security_group_id = aws_security_group.jenkins-sg.id

  cidr_ipv4 = "0.0.0.0/0"

  ip_protocol = "-1"
}

# Consul security group
resource "aws_security_group" "consul-sg" {
  name   = "consul-sg"
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
}

resource "aws_vpc_security_group_egress_rule" "consul-egress" {
  security_group_id = aws_security_group.consul-sg.id

  cidr_ipv4 = "0.0.0.0/0"

  ip_protocol = "-1"
}
