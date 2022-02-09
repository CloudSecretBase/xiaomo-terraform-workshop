resource "aws_iam_role" "grafana_labs_cloudwatch_integration" {
  name        = var.iam_role_name
  description = "Role used by Grafana CloudWatch Integration."

  # Allow Grafana Labs' AWS account to assume this role.
  assume_role_policy = data.aws_iam_policy_document.trust_grafana.json

  # This policy allows the role to discover metrics via tags and export them.
  inline_policy {
    name   = var.iam_role_name
    policy = jsonencode({
      Version   = "2012-10-17"
      Statement = [
        {
          Effect = "Allow"
          Action = [
            "tag:GetResources",
            "cloudwatch:GetMetricData",
            "cloudwatch:GetMetricStatistics",
            "cloudwatch:ListMetrics"
          ]
          Resource = "*"
        }
      ]
    })
  }
}