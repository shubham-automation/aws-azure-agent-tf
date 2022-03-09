resource "random_string" "random_str" {
  length  = 5
  upper   = true
  lower   = true
  number  = false
  special = false
}

resource "aws_security_group" "security_group" {
  name        = "agentsg${random_string.random_str.result}"
  description = var.security_group_description
  vpc_id      = var.vpc_id
}