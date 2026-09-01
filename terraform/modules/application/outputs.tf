output "load_balancer_public_ip" {
  value = aws_instance.load-balancer.public_ip
}

output "web_private_ips" {
  value = aws_instance.web[*].private_ip
}

output "database_private_ip" {
  value = aws_instance.database.private_ip
}
