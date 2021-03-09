/* security group for RDB */
resource "aws_security_group_rule" "kb-rds-sg-rule1" {
  description       = "kb-rds-sg-rule1"
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0", "0.0.0.0/16"]
  security_group_id = aws_security_group.kb-rds-sg.id
}
resource "aws_security_group_rule" "kb-rds-sg-rule2" {
  description       = "kb-rds-sg-rule2"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.kb-rds-sg.id
}
resource "aws_security_group_rule" "kb-rds-sg-rule3" {
  description       = "kb-rds-sg-rule3"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.kb-rds-sg.id
}
resource "aws_security_group_rule" "kb-rds-sg-rule4" {
  description       = "kb-rds-sg-rule4"
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.kb-alb-sg.id
  security_group_id        = aws_security_group.kb-rds-sg.id
}

/* security group for ALB*/
resource "aws_security_group_rule" "kb-alb-sg-rule1" {
  description       = "kb-alb-sg-rule1"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0", "0.0.0.0/16"]
  security_group_id = aws_security_group.kb-alb-sg.id
}
resource "aws_security_group_rule" "kb-alb-sg-rule2" {
  description       = "kb-alb-sg-rule2"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0", "0.0.0.0/16"]
  security_group_id = aws_security_group.kb-alb-sg.id
}
resource "aws_security_group_rule" "kb-alb-sg-rule3" {
  description       = "kb-alb-sg-rule3"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.kb-alb-sg.id
}
resource "aws_security_group_rule" "kb-alb-sg-rule4" {
  description       = "kb-alb-sg-rule4"
  type              = "ingress"
  from_port         = 8
  to_port           = 0
  protocol          = "icmp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.kb-alb-sg.id
}
resource "aws_security_group_rule" "kb-alb-sg-rule5" {
  description       = "kb-alb-sg-rule5"
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.kb-alb-sg.id
}
resource "aws_security_group_rule" "kb-alb-sg-rule6" {
  description       = "kb-alb-sg-rule6"
  type              = "ingress"
  from_port         = 3000
  to_port           = 3000
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.kb-alb-sg.id
}


/* security group for ECS */
resource "aws_security_group_rule" "kb-ecs-sg-rule1" {
  description       = "kb-ecs-sg-rule1"
  type              = "ingress"
  from_port         = 8
  to_port           = 0
  protocol          = "icmp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.kb-ecs-sg.id
}
resource "aws_security_group_rule" "kb-ecs-sg-rule2" {
  description       = "kb-ecs-sg-rule2"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.kb-ecs-sg.id
}
resource "aws_security_group_rule" "kb-ecs-sg-rule3" {
  description       = "kb-ecs-sg-rule3"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.kb-ecs-sg.id
}
resource "aws_security_group_rule" "kb-ecs-sg-rule4" {
  description       = "kb-ecs-sg-rule4"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.kb-ecs-sg.id
}
resource "aws_security_group_rule" "kb-ecs-sg-rule5" {
  description              = "kb-ecs-sg-rule5"
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.kb-alb-sg.id
  security_group_id        = aws_security_group.kb-ecs-sg.id
}
resource "aws_security_group_rule" "kb-ecs-sg-rule6" {
  description       = "kb-ecs-sg-rule6"
  type              = "ingress"
  from_port         = 3000
  to_port           = 3000
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.kb-ecs-sg.id
}
resource "aws_security_group_rule" "kb-ecs-sg-rule7" {
  description       = "kb-ecs-sg-rule5"
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.kb-ecs-sg.id
}