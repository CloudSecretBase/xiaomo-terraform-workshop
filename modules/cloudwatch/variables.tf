variable "external_id" {
  type        = string
  description = "This is your Grafana Cloud identifier and is used for security purposes."

  validation {
    condition     = length(var.external_id) > 0
    error_message = "ExternalID is required."
  }
  default = "327768"
}

variable "iam_role_name" {
  type        = string
  default     = "GrafanaLabsCloudWatchIntegration"
  description = "Customize the name of the IAM role used by Grafana for the CloudWatch Integration."
}