resource "aws_ecs_task_definition" "ecs_task" {
  family                   = "hello-world-rapha"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 1024
  memory                   = 2048
  execution_role_arn       = data.aws_iam_role.role.arn

  container_definitions = <<DEFINITION
[
  {
    "image": "999329133891.dkr.ecr.eu-west-1.amazonaws.com/ecr-repo-rapha:hello-world-apache-image",
    "cpu": 1024,
    "memory": 2048,
    "name": "hello-world-container-rapha",
    "networkMode": "awsvpc",
    "portMappings": [
      {
        "containerPort": 80,
        "hostPort": 80,
        "protocol": "tcp"
      }
    ]
  }
]
DEFINITION

}

resource "aws_ecs_cluster" "main" {
  name = "ecs-cluster-rapha"
}

resource "aws_ecs_service" "ecs_service" {
  name            = "ecs-service-rapha"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.ecs_task.arn
  desired_count   = var.ecs_node_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups = [aws_security_group.container_sg.id]
    subnets         = aws_subnet.private_subnet.*.id
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.lb_target_group.id
    container_name   = "hello-world-container-rapha"
    container_port   = 80
  }

  depends_on = [aws_lb_listener.lb_listener]
}