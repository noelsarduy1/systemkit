variable "project_name" {
  type    = string
  default = "tf-init"
}

variable "platforme_name" {
  type    = string
  default = "dev"
}

data "aws_availability_zones" "available" {}

variable "neptune_name" {
  default = "neptune-cluster-demons"
}

variable "neptune_sg_name" {
  default = "neptune-sg"
}

variable "bastion_sg_name" {
  default = "bastion-sg"
}

variable "neptune_count" {
  default = 1
}

variable "ec2_public_key" {
  type    = string
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC/1cUunfPY2ij7AwsDL8Rq9Ggq84GRIXK1g1yCJWyKbkXuH+iBOSAS+Ta4LxobqgLltbsKKAgjoD3dN3CoLaKxbII80r7bYiMukIkCJOlggijThGHiNTERKvDV08As1QzS4Td05fNdYccg9q1wNHlF0mN8ZObtyxtDv23VZejZzdKO6Ok6LuIy/Qiy21r/z9FOwNg3Xj4El0Qkb2rqJl9ar89AYjhPUyXfVDQ4Y8vSG/gB+0OHqj3aakIvVmwEXFYtUBCXhLHheUaRm6RrBYEBtCXhEkfpgvSIv/TH4trglEh4cWCgVKHBRLGJ5wHOjlUt3/hDo4e8Q+oqsjoiNX6oU5TdKRt6Wzuu6G/CoI++YiChDEF9achIBNdpK/dX8XjuQvXYkfMidcIbN1JvvD861QhBDGYfh1RIGu9qv9jGxv2iBNU70f8lqrlQZO/2w6NsuL2NNnk5E4wODVWq7egLhDdaRVhNPHaNHKjQ2PkR8SSRULfB9lbWEmgpyZzK+fU= ubuntu@worker1"
}

variable "private_key_path" {
  default = "~/.ssh/ec2-key-pair"
}

variable "key_name" {
  default = "vpc"
}

variable "id_pref" {
  type     = string
  default  = ""
}

variable "engine_version" {
  type     = string
  default  = ""
}

variable "iam_roles" {
  type     = list(string)
  default  = [""]
}

variable "param_grp_name" {
  type     = string
  default  = ""
}

variable "rep_id" {
  type     = string
  default  = ""
}

variable "snap_id" {
  type     = string
  default  = ""
}

variable "final_snap_id" {
  type     = string
  default  = ""
}

variable "cloudwatch_logs" {
  type     = list(string)
  default  = [""]
}

variable "kms_key" {
  type     = string
  default  = ""
}


variable "ec2_ami" {
  type    = string
  default = "ami-06cf15d6d096df5d2"

}


data "http" "workstation-external-ip" {
  url = "http://ipv4.icanhazip.com"
}

locals {
  workstation-external-cidr = "${chomp(data.http.workstation-external-ip.body)}/32"
}

output "neptune_cluster_arn" {
  value = "${aws_neptune_cluster.cluster.arn}"
}
