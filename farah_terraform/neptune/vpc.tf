
resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
  tags = merge (
    {
        Name = "${var.project_name}-${var.platforme_name}-VPC"
    }
   )
}

