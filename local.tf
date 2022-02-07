locals {
  ec2 = {
    ssh_key        = "aws_suzukaze"
    instance_count = 1
    os             = {
      linux  = "amazon_linux_2",
      ubuntu = "ubuntu"
    }

    amis = {
      "amazon_linux_2" = "ami-03d79d440297083e3"
      "ubuntu"         = "ami-0fe0d4d94786add8e"
    }
  }
}