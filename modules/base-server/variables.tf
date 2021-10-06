variable "region" {
  type        = string
  default     = "ap-northeast-1"
  description = "aws region"
}

variable "amis" {
  type        = map(string)
  default     = {
    ap-northeast-1 = "ami-a3ed72c5"
  }
  description = "AMI ID"
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "ECS instance type"
}

variable "public_key" {
  type        = string
  default     = "~/.ssh/id_rsa.pub"
  description = "SSH public key"
}

variable "security_group_id" {
  type        = string
  default     = "sg-ebf111a1"
  description = "security group id"
}


variable "server_port" {
  type        = number
  default     = 22
  description = "port"
}