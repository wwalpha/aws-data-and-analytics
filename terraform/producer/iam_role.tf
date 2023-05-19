# ----------------------------------------------------------------------------------------------
# IAM Role - Glue Crawler
# ----------------------------------------------------------------------------------------------
resource "aws_iam_role" "raw_crawler" {
  name               = "${upper(var.prefix)}_GlueCrawlerRole"
  assume_role_policy = data.aws_iam_policy_document.glue.json
}

# ----------------------------------------------------------------------------------------------
# AWS Role Policy - Crawler
# ----------------------------------------------------------------------------------------------
resource "aws_iam_role_policy_attachment" "glue_crawler" {
  role       = aws_iam_role.raw_crawler.name
  policy_arn = aws_iam_policy.glue_crawler.arn
}

# ----------------------------------------------------------------------------------------------
# IAM Role - Glue Job
# ----------------------------------------------------------------------------------------------
resource "aws_iam_role" "raw_etl_job" {
  name               = "${upper(var.prefix)}_GlueETLJobRole"
  assume_role_policy = data.aws_iam_policy_document.glue.json
}

# ----------------------------------------------------------------------------------------------
# AWS Role Policy - Glue Job
# ----------------------------------------------------------------------------------------------
resource "aws_iam_role_policy_attachment" "raw_etl_job" {
  role       = aws_iam_role.raw_etl_job.name
  policy_arn = aws_iam_policy.glue_etl.arn
}
