resource "aws_security_group" "consul-sg" {
  name   = "consul-sg"
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "consul-ui" {
  security_group_id = aws_security_group.consul-sg.id

  cidr_ipv4 = "0.0.0.0/0"

  from_port = 8500
  to_port   = 8500

  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "consul-ssh" {
  security_group_id = aws_security_group.consul-sg.id

  cidr_ipv4 = "0.0.0.0/0"

  from_port = 22
  to_port   = 22

  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "consul-egress" {
  security_group_id = aws_security_group.consul-sg.id

  cidr_ipv4 = "0.0.0.0/0"

  ip_protocol = "-1"
}