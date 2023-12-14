
resource "aws_ecs_service" "test-service" {
  name            = "testapp-service"
  cluster         = aws_ecs_cluster.test-cluster.id
  task_definition = aws_ecs_task_definition.test-def.arn
  desired_count   = var.app_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = [aws_security_group.ecs_sg.id]
    subnets          = aws_subnet.private.*.id
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.myapp-tg.arn
    container_name   = "testapp"
    container_port   = var.app_port
  }

 # deployment_controller {
 #   type = "ECS"
 # }

  #placement_constraints {
  #  type       = "memberOf"
  #  expression = "attribute:ecs.availability-zone in [us-east-1a, us-east-1b]"
  #}
  
  #ordered_placement_strategy {
  #  type  = "binpack"
  #  field = "cpu"
  #}

  depends_on = [aws_alb_listener.testapp, aws_iam_role_policy_attachment.ecs_task_execution_role]

}

