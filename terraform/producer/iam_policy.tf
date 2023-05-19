# ----------------------------------------------------------------------------------------------
# AWS IAM Policy Document - Glue
# ----------------------------------------------------------------------------------------------
data "aws_iam_policy_document" "glue" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["glue.amazonaws.com"]
    }
  }
}

# ----------------------------------------------------------------------------------------------
# AWS IAM Policy Document - Glue Crawler
# ----------------------------------------------------------------------------------------------
resource "aws_iam_policy" "glue_crawler" {
  name = "crawler_policy"
  path = "/"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Resource = [
          "${aws_s3_bucket.raw.arn}",
          "${aws_s3_bucket.raw.arn}/*",
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "glue:GetDatabase",
          "glue:GetTable",
          "glue:CreateTable",
          "glue:CreateDatabase",
        ]
        Resource = "*"
      }
    ]
  })
}

# ----------------------------------------------------------------------------------------------
# AWS IAM Policy Document - Glue ETL JOB
# ----------------------------------------------------------------------------------------------
resource "aws_iam_policy" "glue_etl" {
  name = "glue_etl_policy"
  path = "/"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "glue:*",
          "s3:GetBucketLocation",
          "s3:ListBucket",
          "s3:ListAllMyBuckets",
          "s3:GetBucketAcl",
          "ec2:DescribeVpcEndpoints",
          "ec2:DescribeRouteTables",
          "ec2:CreateNetworkInterface",
          "ec2:DeleteNetworkInterface",
          "ec2:DescribeNetworkInterfaces",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeSubnets",
          "ec2:DescribeVpcAttribute",
          "iam:ListRolePolicies",
          "iam:GetRole",
          "iam:GetRolePolicy",
          "cloudwatch:PutMetricData"
        ]
        Resource = ["*"]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "s3:CreateBucket",
          "s3:PutBucketPublicAccessBlock"
        ],
        "Resource" : [
          "arn:aws:s3:::aws-glue-*"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ]
        Resource = [
          "${aws_s3_bucket.raw.arn}",
          "${aws_s3_bucket.raw.arn}/*",
          "${aws_s3_bucket.trusted.arn}",
          "${aws_s3_bucket.trusted.arn}/*",
          "${aws_s3_bucket.refined.arn}",
          "${aws_s3_bucket.refined.arn}/*",
          "${aws_s3_bucket.scripts.arn}",
          "${aws_s3_bucket.scripts.arn}/*",
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
        ]
        Resource = "*"
      }
    ]
  })
}
