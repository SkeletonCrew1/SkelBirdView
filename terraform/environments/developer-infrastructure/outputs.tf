output "jenkins_security_group_id" {
  value = module.jenkins_consul.jenkins_security_group_id
}

output "consul_security_group_id" {
  value = module.jenkins_consul.consul_security_group_id
}

output "vpc_id" {
  value = module.networking.vpc_id
}

output "main_vpc_rt" {
  value = module.networking.application_rt
}

output "main_vpc_cidr" {
  value = var.vpc_cidr
}