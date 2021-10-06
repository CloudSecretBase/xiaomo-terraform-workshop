provider "aws" {
  region = var.region
}

module "ssh-key-name" {
  source     = "./modules/prep-ssh"
  public_key = var.public_key
}

module "nginx-server" {
  source        = "./modules/base-server"
  server_port   = 80
  server_name   = "nginx-server"
  server_script = templatefile("./sh/setup_nginx.sh", { time = timestamp() } )
  amis          = var.amis
  instance_type = var.instance_type
  ssh_key_name  = module.ssh-key-name
}

module "ss-server" {
  source        = "./modules/base-server"
  server_name   = "ss-server"
  server_port   = 8388
  server_script = templatefile("./sh/setup_ss.sh", { password = var.ss_password } )

}