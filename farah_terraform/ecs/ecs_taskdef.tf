resource "aws_ecs_task_definition" "test-def" {
  family                   = "testapp-task"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  container_definitions    = jsonencode([
    {
      name      = "testapp"
      image     = "${aws_ecr_repository.ecr_repo.repository_url}"
      cpu       = 256
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    }
  ])
  
  #volume {
  #  name      = "service-storage"
  #  host_path = "/ecs/service-storage"
  #}

  #placement_constraints {
  #  type       = "memberOf"
  #  expression = "attribute:ecs.availability-zone in [us-east-1a, us-east-1b]"
  #}
}



