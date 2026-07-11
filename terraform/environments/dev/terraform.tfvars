# Variables for VPC and networking
region = "us-east-1"

vpc_cidr = "10.1.0.0/16"

public_subnet_cidr = "10.1.1.0/24"
private_subnet_cidr = "10.1.11.0/24"

vpc_name = "project-vpc-dev"

internet_gateway_name = "internet-gw-dev"

public_network_name = "public-subnet-dev"

private_network_name = "private-subnet-dev"

nat_eip_name = "nat-eip-dev"
nat_gateway_name = "nat-gateway-dev"

public_route_table_name = "public-route-table-dev"
private_route_table_name = "private-route-table-dev"

ssm_sg_name = "ssm-sg-dev"

# Variables for application infrastructure
lb_instance_type = "t3.micro"
lb_name = "Load-Balancer-Server-dev"

web_instances_count = 2
web_instance_type = "t3.micro"
web_name = "Web-Server-dev"

db_instance_type = "c7i-flex.large"
db_name = "Database-Server-dev"

lb_security_group_name = "lb-sg-dev"
web_security_group_name = "web-sg-dev"
db_security_group_name = "db-sg-dev"

dev_infra_bucket = "skeleton-crew-terraform-state-s3-bucket"
dev_infra_key = "dev-infra/application.tfstate"

# VPC peering
vpc_peering_name = "dev"

# S3
bucket_name = "skeleton-crew-flask-application-bucket-dev"

# Application roles
role_name = "general-ec2-role-dev"
role_profile_name = "general-ec2-profile-dev"
role_policy_name = "general-ec2-policy-dev"