resource "random_string" "random_str" {
  length  = 5
  upper   = true
  lower   = true
  number  = false
  special = false
}

resource "aws_autoscaling_group" "ec2_asg" {
  name                      = "AzureAgentAsg${random_string.random_str.result}"
  max_size                  = var.autoscaling_max_size
  min_size                  = var.autoscaling_min_size
  desired_capacity          = var.autoscaling_desired_size
  launch_configuration      = var.launch_configuration_name
  vpc_zone_identifier       = [var.subnet_ids]
  tag {
    propagate_at_launch = true
    key = "Name"
    value = "Azure-Agent"
  }
}