/* クラスター */
resource "aws_ecs_cluster" "kb-ecs-cluster" {
  name = "kb-ecs-cluster"
}


/* フロント側 */

/* タスク定義 */
resource "aws_ecs_task_definition" "kb-front-task" {
  family                   = "kb-front-task"
  cpu                      = "512"
  memory                   = "1024"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  container_definitions    = file("./tasks/kb_front_definition.json")
  execution_role_arn       = module.ecs_task_execution_role.iam_role_arn
}

/* サービス定義 */
resource "aws_ecs_service" "kb-front-ecs-service" {
  name             = "kb-front-ecs-service"
  cluster          = aws_ecs_cluster.kb-ecs-cluster.arn
  task_definition  = "${aws_ecs_task_definition.kb-front-task.family}:${max("${aws_ecs_task_definition.kb-front-task.revision}", "${data.aws_ecs_task_definition.kb-front-task.revision}")}"
  desired_count    = 1
  launch_type      = "FARGATE"
  platform_version = "1.3.0"
  health_check_grace_period_seconds = 600

  network_configuration {
    assign_public_ip = true
    security_groups = [
      aws_security_group.kb-ecs-sg.id
    ]
    subnets = [
      aws_subnet.kb-front-1a.id,
      aws_subnet.kb-front-1c.id
    ]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.kb-alb-front-tg.arn
    container_name   = "front-container"
    container_port   = "80"
  }
}


/* バック側 */

/* タスク定義 */
resource "aws_ecs_task_definition" "kb-back-task" {
  family                   = "kb-back-task"
  cpu                      = "256"
  memory                   = "512"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  container_definitions    = file("./tasks/kb_back_definition.json")
  execution_role_arn       = module.ecs_task_execution_role.iam_role_arn
}

/* サービス定義 */
resource "aws_ecs_service" "kb-back-ecs-service" {
  name             = "kb-back-ecs-service"
  cluster          = aws_ecs_cluster.kb-ecs-cluster.arn
  task_definition  = "${aws_ecs_task_definition.kb-back-task.family}:${max("${aws_ecs_task_definition.kb-back-task.revision}", "${data.aws_ecs_task_definition.kb-back-task.revision}")}"
  desired_count    = 1
  launch_type      = "FARGATE"
  platform_version = "1.3.0"
  health_check_grace_period_seconds = 600

  network_configuration {
    assign_public_ip = true
    security_groups = [
      aws_security_group.kb-ecs-sg.id
    ]
    subnets = [
      aws_subnet.kb-back-1a.id,
      aws_subnet.kb-back-1c.id
    ]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.kb-alb-back-tg.arn
    container_name   = "back-container"
    container_port   = "3000"
  }
}

/* マイグレーション用タスク */
resource "aws_ecs_task_definition" "db-migrate" {
  family                   = "kb-db-migrate"
  container_definitions    = file("./tasks/kb_db_migrate_definition.json")
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = module.ecs_task_execution_role.iam_role_arn
}

/* ファミリーを指定するだけで、そのファミリーの最新のACTIVEリビジョンを見つけることができる */
data "aws_ecs_task_definition" "kb-front-task" {
  depends_on = [aws_ecs_task_definition.kb-front-task]
  task_definition = aws_ecs_task_definition.kb-front-task.family
}
data "aws_ecs_task_definition" "kb-back-task" {
  depends_on = [aws_ecs_task_definition.kb-back-task]
  task_definition = aws_ecs_task_definition.kb-back-task.family
}


data "aws_iam_policy" "ecs_task_execution_role_policy" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

data "aws_iam_policy_document" "ecs_task_execution" {
  source_json = data.aws_iam_policy.ecs_task_execution_role_policy.policy

  statement {
    effect    = "Allow"
    actions   = ["ssm:GetParameters", "kms:Decrypt"]
    resources = ["*"]
  }
}

module "ecs_task_execution_role" {
  source     = "./iam_role"
  name       = "ecs-task-execution"
  identifier = "ecs-tasks.amazonaws.com"
  policy     = data.aws_iam_policy_document.ecs_task_execution.json
}