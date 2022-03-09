output "sg_id" {
  value = module.ec2_security_group.sg_id
}

output "iam_role_name" {
  value = module.iam_role.iam_role_name
}

output "instance_profile_name" {
  value = module.instance_profile.instance_profile_name
}

output "launch_configuration_name" {
  value = module.ec2_launch_configuration.launch_configuration_name
}