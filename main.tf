module "ec2_security_group" {
  source                     = "./modules/security_group/sg"
  security_group_description = "Allow ssh"
  vpc_id                     = var.vpc_id
  security_group_name        = ""
}

module "ec2_security_group_ingress" {
  source            = "./modules/security_group/sg_ingress"
  ingress_from_port = var.ec2_sg_ingress_from_port
  ingress_protocol  = var.ec2_sg_ingress_protocol
  ingress_to_port   = var.ec2_sg_ingress_to_port
  sg_id             = module.ec2_security_group.sg_id
  cidr              = var.cidr_block
}

module "ec2_security_group_egress" {
  source = "./modules/security_group/sg-egress"
  sg_id  = module.ec2_security_group.sg_id
}

module "ec2_launch_configuration" {
  source                = "./modules/launch_configuration"
  ebs_volume_size       = var.ebs_volume_size
  instance_type         = var.instance_type
  security_group_id     = module.ec2_security_group.sg_id
  instance_profile_name = module.instance_profile.instance_profile_name
  ado_url               = var.ado_url
  azure_agent_role      = var.azure_agent_role
  cloud                 = var.cloud
  environment           = var.environment
  pat                   = var.pat
  pool_name             = var.pool_name
  ssh_key_name          = var.ssh_key_name
}

module "ec2_autoscaling_group" {
  source                    = "./modules/autoscaling"
  autoscaling_desired_size  = var.autoscaling_desired_size
  autoscaling_max_size      = var.autoscaling_max_size
  autoscaling_min_size      = var.autoscaling_min_size
  launch_configuration_name = module.ec2_launch_configuration.launch_configuration_name
  subnet_ids                = var.subnet_ids
}

module "iam_role" {
  source        = "./modules/iam_role"
  iam_role_name = var.iam_role_name
}

module "instance_profile" {
  source        = "./modules/instance_profile"
  iam_role_name = module.iam_role.iam_role_name
}

module "iam_policy" {
  source        = "./modules/iam_policy"
  iam_role_name = module.iam_role.iam_role_name
}