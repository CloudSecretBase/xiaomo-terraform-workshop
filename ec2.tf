module "ec2" {
  source         = "./modules/ec2"
  ami            = lookup(local.ec2.amis, local.ec2.os.linux)
  ssh_key        = local.ec2.ssh_key
  instance_count = 1
  name           = "ec2 from terraform module"
}