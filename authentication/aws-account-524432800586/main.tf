terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "xiaomo1992"

    workspaces {
      name = "aws-account-524432800586"
    }
  }
}
