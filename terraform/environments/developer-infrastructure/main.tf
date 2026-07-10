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

module "jenkins_consul" {

  source = "../../modules/jenkins_consul"

  region = var.region

  jenkins_ami = data.aws_ami.golden-image.id
  jenkins_instance_type = var.jenkins_instance_type
  jenkins_subnet_id = module.networking.private_subnet
  jenkins_disk_size = var.jenkins_disk_size
  jenkins_name = var.jenkins_name
  jenkins_role_name = var.jenkins_role_name
  jenkins_profile_name = var.jenkins_profile_name
  jenkins_policy_name = var.jenkins_policy_name

  consul_ami = data.aws_ami.golden-image.id
  consul_instance_type = var.consul_instance_type
  consul_subnet_id = module.networking.private_subnet
  consul_name = var.consul_name
  consul_role_name = var.consul_role_name
  consul_profile_name = var.consul_name
  consul_policy_name = var.consul_policy_name

  dev_infra_vpc_id = module.networking.vpc_id

}