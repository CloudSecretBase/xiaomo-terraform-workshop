provider "aws" {
  region = "ap-northeast-1"
    profile = "g123-stg"
}


resource "aws_instance" "web" {
  ami           = "ami-a3ed72c5"
  instance_type = "t2.micro"
  tags = {
    "resource" = "ec2"
    yor_trace  = "42e1b2d2-70a6-4229-9324-efeeb4c64de8"
  }
}