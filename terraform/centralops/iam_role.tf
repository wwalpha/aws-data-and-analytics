# ----------------------------------------------------------------------------------------------
# AWS IAM Role - LakeFormation
# ----------------------------------------------------------------------------------------------
resource "aws_iam_role" "lakeformation" {
  name               = "${upper(var.prefix)}_LakeFormationDataAccessRole"
  assume_role_policy = data.aws_iam_policy_document.lakeformation.json
}

# ----------------------------------------------------------------------------------------------
# IAM Role Policy Attachment - Service Role
# ----------------------------------------------------------------------------------------------
# resource "aws_iam_role_policy_attachment" "lakeformation_service_role" {
#   role       = aws_iam_role.lakeformation.name
#   policy_arn = data.aws_iam_policy.lakeformation_data_access.arn
# }

# ----------------------------------------------------------------------------------------------
# IAM Role Policy Attachment - LakeFormation S3 Permission
# ----------------------------------------------------------------------------------------------
resource "aws_iam_role_policy_attachment" "lakeformation_s3" {
  role       = aws_iam_role.lakeformation.name
  policy_arn = aws_iam_policy.lakeformation.arn
}
