resource "aws_instance" this {
  ami           = "ami-03d79d440297083e3"
  instance_type = var.instanceType
  key_name = "aws_suzukaze"
  tags          = {
    Name = var.name
  }
}