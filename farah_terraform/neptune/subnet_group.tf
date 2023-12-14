
resource "aws_neptune_subnet_group" "subnet_group" {
  name       = "subnet-group"
  subnet_ids = ["${aws_subnet.subnet1.id}", "${aws_subnet.subnet2.id}"]

  tags = merge(
    {
      "Name" = format("%s-%s-ec2-sg",var.project_name,var.platforme_name)
    })
}
