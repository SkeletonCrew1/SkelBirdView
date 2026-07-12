# Variables for VPC and networking
region = "us-east-1"

vpc_cidr = "10.2.0.0/16"

public_subnet_cidr = "10.2.1.0/24"
private_subnet_cidr = "10.2.11.0/24"

vpc_name = "project-vpc-stage"

internet_gateway_name = "internet-gw-stage"

public_network_name = "public-subnet-stage"

private_network_name = "private-subnet-stage"

nat_eip_name = "nat-eip-stage"
nat_gateway_name = "nat-gateway-stage"

public_route_table_name = "public-route-table-stage"
private_route_table_name = "private-route-table-stage"

ssm_sg_name = "ssm-sg-stage"

# Variables for application infrastructure
lb_instance_type = "t3.micro"
lb_name = "Load-Balancer-Server-stage"

web_instances_count = 2
web_instance_type = "t3.micro"
web_name = "Web-Server-stage"

db_instance_type = "c7i-flex.large"
db_name = "Database-Server-stage"

lb_security_group_name = "lb-sg-stage"
web_security_group_name = "web-sg-stage"
db_security_group_name = "db-sg-stage"

dev_infra_bucket = "skeleton-crew-terraform-state-s3-bucket"
dev_infra_key = "dev-infra/application.tfstate"

# VPC peering
vpc_peering_name = "stage"

# S3
bucket_name = "skeleton-crew-flask-application-bucket-stage"

# Application roles
role_name = "general-ec2-role-stage"
role_profile_name = "general-ec2-profile-stage"
role_policy_name = "general-ec2-policy-stage"