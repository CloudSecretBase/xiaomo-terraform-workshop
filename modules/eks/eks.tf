resource "aws_eks_cluster" "cluster" {
  name     = local.cluster_name
  role_arn = aws_iam_role.eks-master.arn
  #  version  = local.cluster_version

  vpc_config {
    security_group_ids = [aws_security_group.eks-master.id]
    subnet_ids         = tolist(aws_subnet.sn.*.id)
  }

  depends_on = [
    "aws_iam_role_policy_attachment.eks-cluster",
    "aws_iam_role_policy_attachment.eks-service",
  ]
  tags = {
    git_commit           = "d7ef81dda8108ae72532cd8fcb27277523383fa3"
    git_file             = "modules/eks/eks.tf"
    git_last_modified_at = "2021-10-08 10:47:45"
    git_last_modified_by = "ko.h@ctw.inc"
    git_modifiers        = "ko.h"
    git_org              = "houko"
    git_repo             = "terraform-aws"
    yor_trace            = "4cf1a67a-2203-4b20-8c6e-a0c108848d45"
  }
}

locals {
  userdata = <<USERDATA
#!/bin/bash
set -o xtrace
/etc/eks/bootstrap.sh --apiserver-endpoint "${aws_eks_cluster.cluster.endpoint}" --b64-cluster-ca "${aws_eks_cluster.cluster.certificate_authority.0.data}" "${aws_eks_cluster.cluster.name}"
USERDATA
}

data "aws_ami" "eks-node" {
  most_recent = true
  owners      = ["602401143452"] // 镜像id

  filter {
    name   = "name"
    values = ["amazon-eks-node-${aws_eks_cluster.cluster.version}-v*"]
  }
}

resource "aws_launch_configuration" "lc" {
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.eks-node.id
  image_id                    = data.aws_ami.eks-node.image_id
  instance_type               = var.instance_type
  name_prefix                 = "eks-node"
  key_name                    = var.key_name

  root_block_device {
    volume_type = "gp2"
    volume_size = "50"
  }

  security_groups  = [aws_security_group.eks-node.id]
  user_data_base64 = base64encode(local.userdata)

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "asg" {
  name                 = "EKS node autoscaling group"
  desired_capacity     = var.desired_capacity
  launch_configuration = aws_launch_configuration.lc.id
  max_size             = var.max_size
  min_size             = var.min_size
  vpc_zone_identifier  = tolist(aws_subnet.sn.*.id)

  tag {
    key                 = "Name"
    value               = "eks-asg"
    propagate_at_launch = true
  }

  tag {
    key                 = "kubernetes.io/cluster/${local.cluster_name}"
    value               = "owned"
    propagate_at_launch = true
  }
}