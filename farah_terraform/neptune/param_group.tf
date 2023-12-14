resource "aws_neptune_cluster_parameter_group" "param_group" {
  family      = "neptune1"
  name        = "param-group"
  description = "neptune cluster parameter group"

  parameter {
    name  = "neptune_enable_audit_log"
    value = 1
  }
}
