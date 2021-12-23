provider "aws" {
  region  = "ap-northeast-1"
  profile = "stg"
}


resource "aws_instance" "web" {
  ami           = "ami-a3ed72c5"
  instance_type = "t2.micro"
  tags = {
    git_commit           = "N/A"
    git_file             = "test/main.tf"
    git_last_modified_at = "2021-12-23 22:18:25"
    git_last_modified_by = "suzukaze.hazuki2020@gmail.com"
    git_modifiers        = "suzukaze.hazuki2020"
    git_org              = "houko"
    git_repo             = "terraform-aws"
    yor_trace            = "35962ac5-de86-4472-8e47-de3183ea0770"
  }
}