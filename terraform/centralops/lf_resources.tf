# data "aws_s3_bucket" "this" {
#   bucket = var.producer_buckets[0].raw
# }

# ----------------------------------------------------------------------------------------------
# LakeFormation Resource - Producer Raw
# ----------------------------------------------------------------------------------------------
# resource "aws_lakeformation_resource" "raw" {
#   arn = data.aws_s3_bucket.this.arn
# }
