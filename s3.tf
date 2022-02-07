module "s3" {
  source      = "./modules/s3"
  bucket_name = "test"
  acl         = local.s3.acl.public_read
}