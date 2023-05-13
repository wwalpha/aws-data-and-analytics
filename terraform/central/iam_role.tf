# AWSGlueServiceRole-
# ----------------------------------------------------------------------------------------------
# IAM Role - Glue Crawler
# ----------------------------------------------------------------------------------------------
resource "aws_iam_role" "glue_crawler" {
  name               = "${upper(var.prefix)}_GlueCrawlerRole"
  assume_role_policy = data.aws_iam_policy_document.glue.json
}
