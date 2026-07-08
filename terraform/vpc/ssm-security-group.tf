resource "aws_security_group" "ssm-sg" {
  name   = "ssm-sg"
  vpc_id = aws_vpc.main.id
}

resource "aws_vpc_security_group_ingress_rule" "ssm-http" {
  security_group_id = aws_security_group.ssm-sg.id

  cidr_ipv4 = "0.0.0.0/0"
  from_port = 443
  to_port   = 443

  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "ssm-default" {
  security_group_id = aws_security_group.ssm-sg.id

  referenced_security_group_id = aws_security_group.ssm-sg.id

  ip_protocol = "-1"
}

resource "aws_vpc_security_group_egress_rule" "ssm-egress" {
  security_group_id = aws_security_group.ssm-sg.id

  cidr_ipv4 = "0.0.0.0/0"

  ip_protocol = "-1"
}