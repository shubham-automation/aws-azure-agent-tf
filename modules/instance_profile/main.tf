resource "random_string" "random_str" {
  length  = 5
  upper   = true
  lower   = true
  number  = false
  special = false
}

resource "aws_iam_instance_profile" "instance_profile" {
  name = "userServiceRoleInstanceProfile${random_string.random_str.result}"
  role = var.iam_role_name
}