# ----------------------------------------------------------------------------------------------
# AWS IAM Policy Document - LakeFormation
# ----------------------------------------------------------------------------------------------
data "aws_iam_policy_document" "lakeformation" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lakeformation.amazonaws.com"]
    }
  }
}

# ----------------------------------------------------------------------------------------------
# IAM Policy - LakeFormation Data Access Policy
# ----------------------------------------------------------------------------------------------
data "aws_iam_policy" "lakeformation_data_access" {
  name = "LakeFormationDataAccessServiceRolePolicy"
}

# ----------------------------------------------------------------------------------------------
# IAM Policy - Lakeformation
# ----------------------------------------------------------------------------------------------
resource "aws_iam_policy" "lakeformation" {
  name = "LakeFormationDataAccessPolicy"
  path = "/aws-service-role/"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:DeleteObject"
        ]
        Resource = [for buckent_name in var.producer_buckets : "arn:aws:s3:::${buckent_name}/*"]
      },
      {
        Effect = "Allow"
        Action = [
          "s3:ListBucket"
        ],
        Resource = [for buckent_name in var.producer_buckets : "arn:aws:s3:::${buckent_name}/*"]
      },
      {
        Effect = "Allow"
        Action = [
          "s3:ListAllMyBuckets"
        ],
        Resource = [for buckent_name in var.producer_buckets : "arn:aws:s3:::${buckent_name}/*"]
      }
    ]
  })
}
