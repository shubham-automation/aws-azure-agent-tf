resource "aws_security_group_rule" "sg_ingress" {
  type              = "ingress"
  from_port         = var.ingress_from_port
  to_port           = var.ingress_to_port
  protocol          = var.ingress_protocol
  cidr_blocks       = tolist([var.cidr])
  security_group_id = var.sg_id
}