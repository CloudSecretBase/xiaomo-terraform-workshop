module "ec2" {
  source         = "./modules/ec2"
  ami            = lookup(local.ec2.amis, local.ec2.os.linux)
  ssh_key        = local.ec2.ssh_key
  instance_count = local.ec2.instance_count
  user_data      = templatefile("./templates/amazon_linx_2_httpd.tpl", {})
  name           = "ec2 from terraform module"
}