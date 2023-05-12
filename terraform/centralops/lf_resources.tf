# ----------------------------------------------------------------------------------------------
# LakeFormation Resource - Producer Raw
# ----------------------------------------------------------------------------------------------
resource "aws_lakeformation_resource" "raw" {
  arn      = "arn:aws:s3:::${var.producer_buckets[0].raw}"
  role_arn = aws_iam_role.lakeformation.arn
}
