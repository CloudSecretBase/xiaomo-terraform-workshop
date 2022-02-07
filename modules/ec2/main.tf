resource "aws_instance" this {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.ssh_key
  count         = var.instance_count
  tags          = {
    Name = var.name
  }
}