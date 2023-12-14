
resource "aws_neptune_cluster" "cluster" {
  cluster_identifier                  = "${var.neptune_name}"
  engine                              = "neptune"
  skip_final_snapshot                 = true
  iam_database_authentication_enabled = false
  apply_immediately                   = true
  vpc_security_group_ids              = ["${aws_security_group.neptune_sg.id}"]
  neptune_subnet_group_name           = "${aws_neptune_subnet_group.subnet_group.name}"


  backup_retention_period           = 5
  preferred_backup_window           = "07:00-09:00" 
  # cluster_identifier_prefix         = "${var.id_pref}"
  copy_tags_to_snapshot             = true
  # enable_cloudwatch_logs_exports    = "${var.cloudwatch_logs}"
  engine_version                    = "${var.engine_version}"
  # final_snapshot_identifier         = var.final_snap_id
  iam_roles                         = ["${aws_iam_role.role.arn}"]
  kms_key_arn                       = "${var.kms_key}"
  neptune_cluster_parameter_group_name = "${aws_neptune_cluster_parameter_group.param_group.name}"
  preferred_maintenance_window      = "wed:04:00-wed:04:30"
  port                              = 8182
  replication_source_identifier     = "${var.rep_id}"
  snapshot_identifier               = "${var.snap_id}"
  # storage_encrypted                 = false	
  # deletion_protection               = disabled

  tags = merge(
    {
      "Name" = format("%s-%s-ec2-sg",var.project_name,var.platforme_name)
    })
}




resource "aws_neptune_cluster_instance" "cluster_instance" {
  count                               = "${var.neptune_count}"
  cluster_identifier                  = "${aws_neptune_cluster.cluster.id}"
  engine                              = "neptune"
  instance_class                      = "db.t3.medium"
  apply_immediately                   = true
  neptune_subnet_group_name           = "${aws_neptune_subnet_group.subnet_group.name}"


  auto_minor_version_upgrade        = true
  promotion_tier                    = 0
  publicly_accessible               = false

  tags = merge(
    {
      "Name" = format("%s-%s-ec2-sg",var.project_name,var.platforme_name)
    })
}

