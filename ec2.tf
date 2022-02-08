module "linux2" {
  source         = "./modules/ec2"
  ami            = data.aws_ami.ami_linux2.id
  ssh_key        = local.ec2.ssh_key
  instance_count = local.ec2.instance_count
  user_data      = templatefile("./templates/amazon_linx_2_httpd.tpl", {})
  name           = "amazon linux2 server"
}

module "ubuntu" {
  source         = "./modules/ec2"
  ami            = data.aws_ami.ami_ubuntu.id
  ssh_key        = local.ec2.ssh_key
  instance_count = local.ec2.instance_count
  name           = "ubuntu server"
}

module "centos7" {
  source         = "./modules/ec2"
  ami            = data.aws_ami.ami_ubuntu.id
  ssh_key        = local.ec2.ssh_key
  instance_count = local.ec2.instance_count
  name           = "centos7 server"
}