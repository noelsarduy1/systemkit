resource "aws_ecs_cluster" "test-cluster" {
  name = "myapp-cluster"
  capacity_providers = ["FARGATE"]

  default_capacity_provider_strategy {
    capacity_provider = "FARGATE"
    weight            = "100"
  }
  configuration {
    execute_command_configuration {
      kms_key_id = aws_kms_key.example.arn
      logging    = "OVERRIDE"

      log_configuration {
        cloud_watch_encryption_enabled = true
        cloud_watch_log_group_name     = aws_cloudwatch_log_group.example.name
      }
    }
  }
  tags = merge(
    {
      "Name" = format("%s-%s-ecs-cluster",var.project_name,var.platforme_name)
    })

}

resource "aws_kms_key" "example" {
  description             = "example"
  deletion_window_in_days = 7
}

resource "aws_cloudwatch_log_group" "example" {
  name = "example"
}

