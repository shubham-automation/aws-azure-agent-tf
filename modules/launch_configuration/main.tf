resource "random_string" "random_str" {
  length  = 5
  upper   = true
  lower   = true
  number  = false
  special = false
}

data "aws_ami" "amazon2_linux_ami" {
  most_recent = true
  owners      = ["137112412989"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_launch_configuration" "launch_configuration" {
  name                 = "AzureAgentLC${random_string.random_str.result}"
  iam_instance_profile = var.instance_profile_name
  root_block_device {
    volume_size = var.ebs_volume_size
  }
  instance_type                        = var.instance_type
  image_id                             = data.aws_ami.amazon2_linux_ami.id
  key_name                             = var.ssh_key_name
  security_groups                      = tolist([var.security_group_id])
  associate_public_ip_address          = false
  user_data_base64                     = base64encode(data.template_file.ec2_user_data.rendered)
}

data "template_file" "ec2_user_data" {
  template = file("${path.module}/user-data.tpl")
  vars = {
    cloud       = var.cloud
    environment = var.environment
    role        = var.azure_agent_role
    pat         = var.pat
    ado_url     = var.ado_url
    pool_name   = var.pool_name
  }
}