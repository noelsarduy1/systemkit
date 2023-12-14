resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags = merge(
    {
      "Name" = format("%s-%s-ec2-sg",var.project_name,var.platforme_name)
    })
}
