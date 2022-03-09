resource "random_string" "random_str" {
  length  = 5
  upper   = true
  lower   = true
  number  = false
  special = false
}

resource "aws_iam_policy" "iam_policy" {
  name        = "userServiceRoleBuildAgent${random_string.random_str.result}"
  path        = "/"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ecs:*",
          "logs:*",
          "ecr:*",
          "cloudformation:*",
          "iam:*",
          "ec2:*",
          "eks:*",
          "elasticloadbalancing:*",
          "kms:Get*",
          "kms:List*",
          "kms:Decrypt",
          "kms:Describe*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_policy_attachment" "policy_attachment" {
  name       = "PolicyAttachment${random_string.random_str.result}"
  roles      = [var.iam_role_name]
  policy_arn = aws_iam_policy.iam_policy.arn
}