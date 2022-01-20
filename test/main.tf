provider "aws" {
  region = "ap-northeast-1"
  #  profile = "stg"
}


#resource "aws_instance" "web" {
#  ami           = "ami-a3ed72c5"
#  instance_type = "t2.micro"
#  tags = {
#    git_commit           = "a4191d0a57e0826bdc754284adb6ad56b514ebd1"
#    git_file             = "test/main.tf"
#    git_last_modified_at = "2021-12-23 22:22:13"
#    git_last_modified_by = "suzukaze.hazuki2020@gmail.com"
#    git_modifiers        = "suzukaze.hazuki2020"
#    git_org              = "houko"
#    git_repo             = "terraform-aws"
#    yor_trace            = "35962ac5-de86-4472-8e47-de3183ea0770"
#  }
#}


# exist  i-05d8a484a9c660ee2


resource "aws_instance" "matt_ec2" {
  ami                    = "ami-032d6db78f84e8bf5"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["sg-0cdfdc87967be9eeb"]
  key_name               = "suzukaze_hazuki"
  subnet_id              = "subnet-097c599849fc3d92a"
  tags = {
    git_commit           = "N/A"
    git_file             = "test/main.tf"
    git_last_modified_at = "2022-01-20 23:23:39"
    git_last_modified_by = "suzukaze.hazuki2020@gmail.com"
    git_modifiers        = "suzukaze.hazuki2020"
    git_org              = "houko"
    git_repo             = "terraform-aws"
    yor_trace            = "1bef827f-7396-49f2-8697-9a7e6f7c75df"
  }
}