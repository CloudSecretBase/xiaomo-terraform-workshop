resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
  acl    = var.acl

  versioning {
    enabled = var.version_enabled
  }

  force_destroy = var.force_destroy
}

resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.this.id

  policy = jsonencode({
    "Version" : "2012-10-17"
    "Statement" : [
      {
        "Sid" : "allow-roles",
        "Effect" : "Allow",
        "Principal" : "*",
        "Action" : "s3:*",
        "Resource" : "arn:aws:s3:::${aws_s3_bucket.this.id}/*"
        "Condition" : {
          "ArnLike" : {
            "aws:SourceArn" : [
              "arn:aws:iam::${data.aws_caller_identity.self.account_id}:user/*",
              "arn:aws:iam::${data.aws_caller_identity.self.account_id}:role/${var.bucket_name}*",
            ]
          }
        }
      },
    ]
  })
}