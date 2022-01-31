variable "name" {
  type        = string
  default     = "terraform-test"
  description = "name of the instance"
}

variable "instanceType" {
  type        = string
  default     = "t2.micro"
  description = "instance type"
}

variable "os" {
  type        = string
  default     = "amazon_linux_2"
  description = "ami id"
}

variable "vpc" {
  type        = string
  default     = "vpc-0d7aeb9c78e9e786a"
  description = "vpc id"
}