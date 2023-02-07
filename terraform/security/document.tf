# ----------------------------------------------------------------------------------------------
# AWS IAM Policy Document - IoT
# ----------------------------------------------------------------------------------------------
data "aws_iam_policy_document" "iot" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["iot.amazonaws.com"]
    }
  }
}
