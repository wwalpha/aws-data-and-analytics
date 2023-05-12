# ----------------------------------------------------------------------------------------------
# IAM Policy Document - Allow access from central account
# ----------------------------------------------------------------------------------------------
data "aws_iam_policy_document" "raw_allow_access_from_another_account" {
  depends_on = [aws_s3_bucket.raw]
  statement {
    principals {
      type        = "AWS"
      identifiers = [var.account_id_centrail]
    }

    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]

    resources = [
      aws_s3_bucket.raw.arn,
      "${aws_s3_bucket.raw.arn}/*",
    ]
  }
}

# ----------------------------------------------------------------------------------------------
# IAM Policy Document - Allow access from central account
# ----------------------------------------------------------------------------------------------
data "aws_iam_policy_document" "trusted_allow_access_from_another_account" {
  depends_on = [aws_s3_bucket.trusted]
  statement {
    principals {
      type        = "AWS"
      identifiers = [var.account_id_centrail]
    }

    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]

    resources = [
      aws_s3_bucket.trusted.arn,
      "${aws_s3_bucket.trusted.arn}/*",
    ]
  }
}

# ----------------------------------------------------------------------------------------------
# IAM Policy Document - Allow access from central account
# ----------------------------------------------------------------------------------------------
data "aws_iam_policy_document" "refined_allow_access_from_another_account" {
  depends_on = [aws_s3_bucket.refined]

  statement {
    principals {
      type        = "AWS"
      identifiers = [var.account_id_centrail]
    }

    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]

    resources = [
      aws_s3_bucket.refined.arn,
      "${aws_s3_bucket.refined.arn}/*",
    ]
  }
}
