/*
 * 基础服务器模块
 */
data "aws_security_groups" "default" {
  filter {
    name   = "group-name"
    values = ["default"]
  }
}

# 创建 EC2 实例
resource "aws_instance" "server" {
  ami           = lookup(var.amis, var.region)
  instance_type = var.instance_type
  key_name      = var.ssh_key_name
  user_data     = var.server_script
  tags = {
    Name                 = var.server_name
    git_commit           = "6c3481ceb650be3968f96610564de806128b0a97"
    git_file             = "modules/base-server/main.tf"
    git_last_modified_at = "2021-10-06 10:21:06"
    git_last_modified_by = "ko.h@ctw.inc"
    git_modifiers        = "ko.h"
    git_org              = "houko"
    git_repo             = "terraform-aws"
    yor_trace            = "575ab611-175f-4f8d-ae14-1c04fe36e170"
  }
  lifecycle {
    create_before_destroy = true
  }
}

# 开放其它端口
resource "aws_security_group_rule" "other" {
  type              = "ingress"
  from_port         = var.server_port
  to_port           = var.server_port
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = data.aws_security_groups.default.ids[0]
}

# 绑定弹性IP地址
resource "aws_eip" "lb" {
  instance = aws_instance.server.id
  vpc      = true
  tags = {
    git_commit           = "3df934b2f43e045014da3b3bf6658de57792cede"
    git_file             = "modules/base-server/main.tf"
    git_last_modified_at = "2021-10-06 14:08:45"
    git_last_modified_by = "xiaomo@xiaomo.info"
    git_modifiers        = "xiaomo"
    git_org              = "houko"
    git_repo             = "terraform-aws"
    yor_trace            = "ff3ed133-20d3-4016-8cfc-8addf6beef07"
  }
}