provider "aws" {
  region  = "ap-northeast-1"
  profile = "xiaomo"
}

module "ssh-key-name" {
  source     = "../modules/prep-ssh"
  public_key = "~/.ssh/id_rsa.pub"
}


module "nginx-server" {
  source        = "../modules/base-server"
  server_name   = "nginx-server"
  server_script = templatefile("../sh/setup_nginx.sh", { time = "hello,2021" } )
  server_port   = 80
  region        = "ap-northeast-1"
  amis          = { ap-northeast-1 = "ami-0cb1c8cab7f5249b6" }
  instance_type = "t2.micro"
  ssh_key_name  = module.ssh-key-name.key_name
}

