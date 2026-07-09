output "jenkins_security_group_id" {
  value = aws_security_group.jenkins-sg.id
}

output "consul_security_group_id" {
  value = aws_security_group.consul-sg.id
}