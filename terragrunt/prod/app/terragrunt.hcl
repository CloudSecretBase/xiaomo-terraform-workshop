terraform {
  source =
  "github.com:foo/infrastructure-modules.git//app?ref=v0.0.1"
}
inputs = {
  instance_count = 10
  instance_type  = "m4.large"
}