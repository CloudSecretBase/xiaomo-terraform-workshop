provider "aws" {
  region = "ap-northeast-1"
  #  profile = "default"
  #  access_key = "my-access-key"
  #  secret_key = "my-secret-key"
}


resource "aws_instance" "web" {
  ami           = "ami-a3ed72c5"
  instance_type = "t2.micro"
  tags = {
    Name                 = var.hello
    git_commit           = "9217b2d89e63adfa214b61ed39b0a8e6d0bc6ebb"
    git_file             = "test2/main.tf"
    git_last_modified_at = "2021-12-23 22:13:24"
    git_last_modified_by = "suzukaze.hazuki2020@gmail.com"
    git_modifiers        = "suzukaze.hazuki2020"
    git_org              = "houko"
    git_repo             = "terraform-aws"
    yor_trace            = "4fd3d06d-6cd1-405d-b3fd-f61d343b4ae6"
  }

}

variable "hello" {
}

