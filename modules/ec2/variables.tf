variable "name" {
  type        = string
  default     = "terraform-test"
  description = "name of the instance"
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "instance type"
}

variable "ami" {
  type        = string
  default     = "amazon_linux_2"
  description = "ami id"
}

variable "vpc" {
  type        = string
  default     = "vpc-0d7aeb9c78e9e786a"
  description = "vpc id"
}

variable "ssh_key" {
  type        = string
  default     = "aws_suzukaze"
  description = "ssh key name"
}

variable "instance_count" {
  type        = number
  default     = 1
  description = "number of instances"
}