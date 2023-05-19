# # ----------------------------------------------------------------------------------------------
# # AWS LakeFormation Data Lake Settings
# # ----------------------------------------------------------------------------------------------
# resource "aws_lakeformation_data_lake_settings" "this" {
#   # admins = [${admin-role-arns}]
# }

# ----------------------------------------------------------------------------------------------
# AWS LakeFormation Resource - Producer Raw
# ----------------------------------------------------------------------------------------------
resource "aws_lakeformation_resource" "this" {
  for_each = toset(var.producer_buckets)
  arn      = "arn:aws:s3:::${each.key}"
  role_arn = aws_iam_role.lakeformation.arn
}

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
