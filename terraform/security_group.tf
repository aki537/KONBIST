/* security group for RDS */
resource "aws_security_group" "kb-rds-sg" {
  description = "RDS security group for kb"
  name        = "kb-rds-sg"
  vpc_id      = aws_vpc.kb-vpc.id
}

/* security group for ALB */
resource "aws_security_group" "kb-alb-sg" {
  description = "ALB security group for kb"
  name        = "kb-alb-sg"
  vpc_id      = aws_vpc.kb-vpc.id
}

/* security group for ECS */
resource "aws_security_group" "kb-ecs-sg" {
  description = "ECS security group for kb"
  name        = "kb-ecs-sg"
  vpc_id      = aws_vpc.kb-vpc.id
}