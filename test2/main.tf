provider "aws" {
  region  = "ap-northeast-1"
  profile = "default"
  #  access_key = "my-access-key"
  #  secret_key = "my-secret-key"
}


resource "aws_instance" "web" {
  ami           = "ami-a3ed72c5"
  instance_type = "t2.micro"
  tags = {
    Name      = var.hello
    yor_trace = "7892aa57-ad70-4644-a094-51e9c670c6e2"
  }

}

variable "hello" {
  default = 'Terraform'
}

