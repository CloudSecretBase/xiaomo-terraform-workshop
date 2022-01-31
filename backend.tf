terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "xiaomo1992"

    workspaces {
      name = "terraform-aws"
    }
  }
}