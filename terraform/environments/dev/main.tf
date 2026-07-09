module "networking" {

  source = "../../modules/networking"

  region = var.region

  vpc_cidr = var.vpc_cidr

  public_subnet_cidr = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr

  vpc_name = var.vpc_name

  internet_gateway_name = var.internet_gateway_name

  public_network_name = var.public_network_name
  private_network_name = var.private_network_name

  nat_eip_name = var.nat_eip_name

  nat_gateway_name = var.nat_gateway_name

  public_route_table_name = var.public_route_table_name
  private_route_table_name = var.private_route_table_name

  ssm_sg_name = var.ssm_sg_name

}

module "application" {

  source = "../../modules/application"

  region = var.region

  lb_instance_type = var.lb_instance_type
  lb_subnet_id = module.networking.public_subnet
  lb_iam_instance_profile = module.application_roles.ec2-profile-name
  lb_name = var.lb_name
  lb_ami = data.aws_ami.golden-image.id

  web_instances_count = var.web_instances_count
  web_ami = data.aws_ami.golden-image.id
  web_instance_type = var.web_instance_type
  web_subnet_id = module.networking.private_subnet
  web_iam_instance_profile = module.application_roles.ec2-profile-name
  web_name = var.web_name

  db_ami = data.aws_ami.golden-image.id
  db_instance_type = var.db_instance_type
  db_subnet_id = module.networking.private_subnet
  db_iam_instance_profile = module.application_roles.ec2-profile-name
  db_name = var.db_name

  lb_security_group_name = var.lb_security_group_name
  web_security_group_name = var.web_security_group_name
  db_security_group_name = var.db_security_group_name
  custom_vpc_id = module.networking.vpc_id

  developers_vpc_cidr = data.terraform_remote_state.dev_infra.outputs.main_vpc_cidr

}

module "vpc_peering" {

  source = "../../modules/vpc_peering"

  main_vpc_cidr = data.terraform_remote_state.dev_infra.outputs.main_vpc_cidr
  application_vpc = module.networking.vpc_id
  vpc_peering_name = var.vpc_peering_name
  main_vpc_rt = data.terraform_remote_state.dev_infra.outputs.main_vpc_rt
  application_vpc_cidr = var.vpc_cidr
  application_vpc_rt = module.networking.application_rt
  main_vpc_id = data.terraform_remote_state.dev_infra.outputs.vpc_id

}

module "s3_app" {

  source = "../../modules/s3_app"

  bucket_name = var.bucket_name

}

module "application_roles" {

  source = "../../modules/application_roles"

  role_name = var.role_name
  role_profile_name = var.role_profile_name
  role_policy_name = var.role_policy_name

}