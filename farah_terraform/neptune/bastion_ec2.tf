resource "aws_instance" "neptune-ec2-connector" {
  connection {
    user        = "ec2-user"
    agent       = "false"
    private_key = "${file(var.private_key_path)}"
  }
  instance_type          = "t4g.nano"
  ami                    = var.ec2_ami
  key_name               = "${aws_key_pair.auth.id}"
  vpc_security_group_ids = ["${aws_security_group.bastion_sg.id}"]
  subnet_id              = "${aws_subnet.subnet1.id}"
  tags = merge(
    {
      "Name" = format("%s-%s-ec2-sg",var.project_name,var.platforme_name)
    })
}

