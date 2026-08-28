# Variables for VPC and networking
region = "eu-north-1"

vpc_cidr = "10.5.0.0/16"

public_subnet_cidr = "10.5.1.0/24"
private_subnet_cidr = "10.5.11.0/24"

vpc_name = "project-vpc-dev-infra"

internet_gateway_name = "internet-gw-dev-infra"

public_network_name = "public-subnet-dev-infra"

private_network_name = "private-subnet-dev-infra"

nat_eip_name = "nat-eip-dev-infra"
nat_gateway_name = "nat-gateway-dev-infra"

public_route_table_name = "public-route-table-dev-infra"
private_route_table_name = "private-route-table-dev-infra"

ssm_sg_name = "ssm-sg-dev-infra"



# Variables for application infrastructure
jenkins_instance_type = "c7i-flex.large"
jenkins_disk_size = 75
jenkins_name = "Jenkins-Server-Test"
jenkins_role_name = "Jenkins-Role-Test"
jenkins_profile_name = "Jenkins-Profile-Test"
jenkins_policy_name = "Jenkins-Policy-Test"

consul_instance_type = "t3.micro"
consul_name = "Consul-Server-Test"
consul_role_name = "Consul-Role-Test"
consul_profile_name = "Consul-Profile-Test"
consul_policy_name = "Consul-Policy-Test"
