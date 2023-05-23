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
# AWS IAM Policy Document - State Machine
# ----------------------------------------------------------------------------------------------
data "aws_iam_policy_document" "sfn" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["states.amazonaws.com"]
    }
  }
}
