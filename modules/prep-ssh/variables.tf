variable "security_group_id" {
  type        = string
  default     = "sg-ebf111a1"
  description = "security group id"
}

variable "public_key" {
  type        = string
  description = "ssh public key"
}