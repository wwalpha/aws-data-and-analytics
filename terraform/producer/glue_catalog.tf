# ----------------------------------------------------------------------------------------------
# AWS Glue Catalog Encryption Settings
# ----------------------------------------------------------------------------------------------
resource "aws_glue_data_catalog_encryption_settings" "this" {
  data_catalog_encryption_settings {
    connection_password_encryption {
      aws_kms_key_id                       = data.aws_kms_alias.glue.arn
      return_connection_password_encrypted = true
    }

    encryption_at_rest {
      catalog_encryption_mode = "SSE-KMS"
      sse_aws_kms_key_id      = data.aws_kms_alias.glue.arn
    }
  }
}

# ----------------------------------------------------------------------------------------------
# AWS Glue Catalog Database - Raw Database
# ----------------------------------------------------------------------------------------------
resource "aws_glue_catalog_database" "raw" {
  name = "${var.prefix}-raw-db"
}

# ----------------------------------------------------------------------------------------------
# AWS Glue Catalog Database - Refined Database
# ----------------------------------------------------------------------------------------------
resource "aws_glue_catalog_database" "refined" {
  name = "${var.prefix}-refined-db"
}

# ----------------------------------------------------------------------------------------------
# Glue Catalog Table - Raw Table
# ----------------------------------------------------------------------------------------------
# resource "aws_glue_catalog_table" "raw" {
#   name          = "${var.prefix}-raw-table"
#   database_name = aws_glue_catalog_database.raw.name
# }

# ----------------------------------------------------------------------------------------------
# AWS Glue Job - Raw ETL
# ----------------------------------------------------------------------------------------------
resource "aws_glue_job" "raw_etl" {
  name     = "${var.prefix}-raw-etl-job"
  role_arn = aws_iam_role.raw_etl_job.arn

  default_arguments = {
    "--enable-glue-datacatalog"          = "true"
    "--enable-auto-scaling"              = "true"
    "--enable-job-insights"              = "true"
    "--job-bookmark-option"              = "job-bookmark-enable"
    "--job-language"                     = "python"
    "--enable-continuous-cloudwatch-log" = "true"
    "--enable-glue-datacatalog"          = "true"
    "--enable-metrics"                   = "true"
    "--enable-spark-ui"                  = "true"
    "--enable-glue-datacatalog"          = "true"
    "--enable-spark-ui"                  = "false"
    # "--TempDir"                          = "s3://aws-glue-assets-334678299258-ap-northeast-1/temporary/"
    # "--spark-event-logs-path"            = "s3://aws-glue-assets-334678299258-ap-northeast-1/sparkHistoryLogs/"
  }

  glue_version      = "4.0"
  execution_class   = "STANDARD"
  number_of_workers = 2
  worker_type       = "G.1X"

  command {
    script_location = "s3://${aws_s3_bucket.scripts.bucket}/${aws_s3_object.raw_etl_script.key}"
  }

  execution_property {
    max_concurrent_runs = 1
  }
}
