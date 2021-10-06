# 基础服务器模块
data "aws_security_group" "default" {
  filter {
    name   = "group-name"
    values = ["default"]
  }
}

# 添加ssh 密钥
resource "aws_key_pair" "ssh" {
  key_name   = "admin"
  public_key = file("~/.ssh/id_rsa")
}


#  开放22端口
# 防火墙规则 开放端口
resource "aws_security_group_rule" "other" {
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = var.security_group_id
  type              = "ingress"
}
