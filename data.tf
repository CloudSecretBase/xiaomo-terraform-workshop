data "external" "vpc" {
  program = ["bash", "./scripts/get_vpc.sh"]
  query   = {
    profile  = "default"
    vpc_name = "default"
  }
}