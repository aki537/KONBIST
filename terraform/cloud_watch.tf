resource "aws_cloudwatch_log_group" "kb-ecs-back" {
  name              = "/ecs/back"
  retention_in_days = 180
}
resource "aws_cloudwatch_log_group" "kb-ecs-front" {
  name              = "/ecs/front"
  retention_in_days = 180
}
resource "aws_cloudwatch_log_group" "kb-ecs-db-migrate" {
  name              = "/ecs/db-migrate"
  retention_in_days = 180
}