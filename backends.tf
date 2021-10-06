terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "ctw"

    workspaces {
      name = "terraform-aws"
    }
  }
}