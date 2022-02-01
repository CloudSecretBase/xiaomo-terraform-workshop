resource "aws_cloud9_environment_ec2" "xiaomo-cloud9" {
  instance_type = "t2.micro"
  name          = var.name
}