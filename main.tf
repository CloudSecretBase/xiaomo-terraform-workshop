terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.58.0"
    }
  }
}

provider "aws" {
  region  = "ap-northeast-1"
  profile = "xiaomo"
}


resource "aws_instance" "test" {
  instance_type = "t2.micro"
  ami           = "ami-da9e2cbc"
}
