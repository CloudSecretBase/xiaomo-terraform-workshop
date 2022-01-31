module "ec2" {
  source = "./modules/ec2"
  os     = local.os_amazon_linx_2
  name   = "ec2 from terraform module"
  #  vpc = data.external.vpc.id
}