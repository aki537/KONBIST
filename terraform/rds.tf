resource "aws_db_parameter_group" "kb-db-parameter" {
  name   = "kb-db-parameter"
  family = "mysql5.7"

  parameter {
    name  = "character_set_database"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_client"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_connection"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_results"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_server"
    value = "utf8mb4"
  }
}

resource "aws_db_instance" "kb-db" {
  allocated_storage       = 20
  instance_class          = "db.t2.micro"
  engine                  = "MySQL"
  engine_version          = "5.7.30"
  storage_type            = "gp2"
  name = "production"
  username                = var.aws_db_user
  password                = var.aws_db_password
  port = 3306
  backup_retention_period = 7
  copy_tags_to_snapshot   = true
  max_allocated_storage   = 200
  skip_final_snapshot     = true
  vpc_security_group_ids  = [aws_security_group.kb-rds-sg.id]
  parameter_group_name = aws_db_parameter_group.kb-db-parameter.name
  db_subnet_group_name    = aws_db_subnet_group.kb-rds-subnet-group.name
  enabled_cloudwatch_logs_exports = [
    "audit",
    "error",
    "general",
    "slowquery",
  ]

  lifecycle {
    prevent_destroy = true
  }

}

variable "aws_db_user" {}
variable "aws_db_password" {}
