# # ----------------------------------------------------------------------------------------------
# # AWS LakeFormation Data Lake Settings
# # ----------------------------------------------------------------------------------------------
# resource "aws_lakeformation_data_lake_settings" "this" {
#   # admins = [${admin-role-arns}]
# }

# ----------------------------------------------------------------------------------------------
# AWS LakeFormation Resource - Producer Raw
# ----------------------------------------------------------------------------------------------
resource "aws_lakeformation_resource" "raw" {
  arn      = "arn:aws:s3:::${var.producer_buckets[count.index].raw}"
  role_arn = aws_iam_role.lakeformation.arn
  count    = length(var.producer_buckets)
}

# # ----------------------------------------------------------------------------------------------
# # AWS LakeFormation Resource - Producer Refined
# # ----------------------------------------------------------------------------------------------
# resource "aws_lakeformation_resource" "refined" {
#   arn      = "arn:aws:s3:::${var.producer_buckets[count.index].refined}"
#   role_arn = aws_iam_role.lakeformation.arn
#   count    = length(var.producer_buckets)
# }

# # ----------------------------------------------------------------------------------------------
# # AWS LakeFormation Resource - Producer Trusted
# # ----------------------------------------------------------------------------------------------
# resource "aws_lakeformation_resource" "trusted" {
#   arn      = "arn:aws:s3:::${var.producer_buckets[count.index].trusted}"
#   role_arn = aws_iam_role.lakeformation.arn
#   count    = length(var.producer_buckets)
# }

# resource "aws_lakeformation_permissions" "database" {
#   principal                     = ${account-target-id}
#   permissions                   = ["DESCRIBE"]
#   permissions_with_grant_option = ["DESCRIBE"]
#   database {
#     name = ${account-source-database-name}
#   }
# }
# resource "aws_lakeformation_permissions" "table" {
#   principal                     = ${account-target-id}
#   permissions                   = ["SELECT"]
#   permissions_with_grant_option = ["SELECT"]
#   table {
#     database_name = ${account-source-database-name}
#     name          = "${account-source-table-name}"
#   }
# }
