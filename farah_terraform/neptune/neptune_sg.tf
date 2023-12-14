resource "aws_security_group" "neptune_sg" {
  name        = "${var.neptune_sg_name}"
  description = "Neptune"
  vpc_id      = "${aws_vpc.vpc.id}"

  ingress {
    from_port = 8182
    to_port   = 8182
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(
    {
      "Name" = format("%s-%s-ec2-sg",var.project_name,var.platforme_name)
    })

}


