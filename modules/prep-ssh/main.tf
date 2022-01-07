/*
 * 准备 SSH
 */
data "aws_security_groups" "default" {
  filter {
    name   = "group-name"
    values = ["default"]
  }
}

# 添加 SSH 登录密钥
resource "aws_key_pair" "ssh" {
  key_name   = "admin"
  public_key = file(var.public_key)
  tags = {
    git_commit           = "6c3481ceb650be3968f96610564de806128b0a97"
    git_file             = "modules/prep-ssh/main.tf"
    git_last_modified_at = "2021-10-06 10:21:06"
    git_last_modified_by = "ko.h@ctw.inc"
    git_modifiers        = "ko.h"
    git_org              = "houko"
    git_repo             = "terraform-aws"
    yor_trace            = "d12b3a9c-028c-4a19-817a-fa1527cb5a5e"
  }
}

# 开放 22 端口，允许 SSH 登录
resource "aws_security_group_rule" "ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = data.aws_security_groups.default.ids[0]
}