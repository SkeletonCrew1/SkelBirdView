output "jenkins-profile-name" {
  value = aws_iam_instance_profile.jenkins-profile.name
}

output "consul-profile-name" {
  value = aws_iam_instance_profile.consul-profile.name
}

output "ssm-profile-name" {
  value = aws_iam_instance_profile.ssm-profile.name
}
