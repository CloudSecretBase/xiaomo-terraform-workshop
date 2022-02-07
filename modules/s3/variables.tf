variable "bucket_name" {
  description = "The name of the S3 bucket to use"
  type        = string
}

variable "acl" {
  description = "The ACL to use for the bucket"
  type        = string
  default     = "private"
}

variable "version_enabled" {
  default     = false
  type        = bool
  description = "Whether to enable versioning on the bucket"
}

variable "force_destroy" {
  default     = false
  type        = bool
  description = "Whether to destroy the bucket if it already exists"
}