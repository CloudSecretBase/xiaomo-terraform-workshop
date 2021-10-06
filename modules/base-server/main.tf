# 基础服务器模块
data "aws_security_group" "default" {
  filter {
    name   = "group-name"
    values = ["default"]
  }
}

#创建ec2服务器
resource "aws_instance" "server" {
  ami = lookup(var.amis, var.region )
}

# 防火墙规则 开放端口
resource "aws_security_group_rule" "other" {
  from_port         = var.server_port
  protocol          = "tcp"
  security_group_id = var.security_group_id
  to_port           = var.server_port
  type              = "ingress"
}
