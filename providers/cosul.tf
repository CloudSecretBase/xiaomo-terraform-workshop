terraform {
  required_providers {
    consul = {
      source = "hashicorp/consul"
      version = "2.13.0"
    }
  }
}

provider "consul" {
  # Configuration options
}