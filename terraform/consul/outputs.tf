output "consul_security_group_id" {
  value = aws_security_group.consul-sg.id
}

output "consul_instance_id" {
  value = aws_instance.consul.id
}

output "consul_private_ip" {
  value = aws_instance.consul.private_ip
}

output "consul_public_ip" {
  value = aws_instance.consul.public_ip
}