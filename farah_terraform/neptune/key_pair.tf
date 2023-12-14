resource "aws_key_pair" "auth" {
  public_key = var.ec2_public_key
  tags = merge(
    {
      "Name" = format("%s-%s-ec2-sg",var.project_name,var.platforme_name)
    })
}
