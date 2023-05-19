# ----------------------------------------------------------------------------------------------
# AWS Glue Crawler - Raw
# ----------------------------------------------------------------------------------------------
resource "aws_glue_crawler" "raw" {
  database_name = aws_glue_catalog_database.raw.name
  name          = "${var.prefix}-raw-crawler"
  role          = aws_iam_role.raw_crawler.arn

  s3_target {
    path       = "s3://${aws_s3_bucket.raw.bucket}/"
    exclusions = []
  }

  lake_formation_configuration {
    use_lake_formation_credentials = false
  }

  configuration = jsonencode({
    Version              = 1
    CreatePartitionIndex = true
  })

  lineage_configuration {
    crawler_lineage_settings = "DISABLE"
  }

  recrawl_policy {
    recrawl_behavior = "CRAWL_EVERYTHING"
  }

  schema_change_policy {
    delete_behavior = "DEPRECATE_IN_DATABASE"
    update_behavior = "UPDATE_IN_DATABASE"
  }
}

# ----------------------------------------------------------------------------------------------
# AWS Glue Crawler - Trusted
# ----------------------------------------------------------------------------------------------
resource "aws_glue_crawler" "trusted" {
  database_name = aws_glue_catalog_database.trusted.name
  name          = "${var.prefix}-trusted-crawler"
  role          = aws_iam_role.raw_crawler.arn

  s3_target {
    path       = "s3://${aws_s3_bucket.trusted.bucket}/"
    exclusions = []
  }

  lake_formation_configuration {
    use_lake_formation_credentials = false
  }

  configuration = jsonencode({
    Version              = 1
    CreatePartitionIndex = true
  })

  lineage_configuration {
    crawler_lineage_settings = "DISABLE"
  }

  recrawl_policy {
    recrawl_behavior = "CRAWL_EVERYTHING"
  }

  schema_change_policy {
    delete_behavior = "DEPRECATE_IN_DATABASE"
    update_behavior = "UPDATE_IN_DATABASE"
  }
}
