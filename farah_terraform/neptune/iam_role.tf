resource "aws_iam_instance_profile" "profile" {
  name = "profile"
  role = "${aws_iam_role.role.name}"
}

resource "aws_iam_role" "role" {
  name = "neptune_role"
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
                "Service": ["ec2.amazonaws.com", "rds.amazonaws.com"]
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF

  tags = merge(
  {
      "Name" = format("%s-%s-test-role",var.project_name,var.platforme_name)
  })

}


resource "aws_iam_role_policy_attachment" "neptune" {
  policy_arn = "arn:aws:iam::aws:policy/NeptuneFullAccess"
  role       = "${aws_iam_role.role.name}"
}
