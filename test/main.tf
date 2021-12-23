provider "aws" {
  region  = "ap-northeast-1"
  profile = "stg"
}


resource "aws_instance" "web" {
  ami = "ami-a3ed72c5"
  instance_type = "t2.micro"
}