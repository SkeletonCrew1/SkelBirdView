# Variables for VPC and networking
region = "us-east-1"

vpc_cidr = "10.3.0.0/16"

public_subnet_cidr = "10.3.1.0/24"
private_subnet_cidr = "10.3.11.0/24"

vpc_name = "project-vpc-prod"

internet_gateway_name = "internet-gw-prod"

public_network_name = "public-subnet-prod"

private_network_name = "private-subnet-prod"

nat_eip_name = "nat-eip-prod"
nat_gateway_name = "nat-gateway-prod"

public_route_table_name = "public-route-table-prod"
private_route_table_name = "private-route-table-prod"

ssm_sg_name = "ssm-sg-prod"

# Variables for application infrastructure
lb_instance_type = "t3.micro"
lb_name = "Load-Balancer-Server-prod"

web_instances_count = 2
web_instance_type = "t3.micro"
web_name = "Web-Server-prod"

db_instance_type = "c7i-flex.large"
db_name = "Database-Server-prod"

lb_security_group_name = "lb-sg-prod"
web_security_group_name = "web-sg-prod"
db_security_group_name = "db-sg-prod"

dev_infra_bucket = "skeleton-crew-terraform-state-s3-bucket"
dev_infra_key = "dev-infra/application.tfstate"

# VPC peering
vpc_peering_name = "prod"

# S3
bucket_name = "skeleton-crew-flask-application-bucket-prod"

# Application roles
role_name = "general-ec2-role-prod"
role_profile_name = "general-ec2-profile-prod"
role_policy_name = "general-ec2-policy-prod"

# Jenkins secrets
web_server_1_private_ip_secret_name = "SERVER1"
web_server_2_private_ip_secret_name = "SERVER2"
database_private_ip_secret_name = "BIRDWATCHING_DB_HOST"
