# ----------------------------------------------------------------------------------------------
# AWS Glue Workflow
# ----------------------------------------------------------------------------------------------
resource "aws_glue_workflow" "this" {
  name                = "${var.prefix}-workflow"
  max_concurrent_runs = 1
}

# ----------------------------------------------------------------------------------------------
# AWS Glue Trigger - Start
# ----------------------------------------------------------------------------------------------
resource "aws_glue_trigger" "start" {
  name              = "${var.prefix}-raw-crawler"
  type              = "ON_DEMAND"
  workflow_name     = aws_glue_workflow.this.name
  start_on_creation = false

  actions {
    crawler_name = aws_glue_crawler.raw.name
  }
}

# ----------------------------------------------------------------------------------------------
# AWS Glue Trigger - Raw ETL Job
# ----------------------------------------------------------------------------------------------
resource "aws_glue_trigger" "raw_etl" {
  name              = "${var.prefix}-raw-etl"
  type              = "CONDITIONAL"
  workflow_name     = aws_glue_workflow.this.name
  start_on_creation = false

  predicate {
    conditions {
      crawler_name = aws_glue_crawler.raw.name
      crawl_state  = "SUCCEEDED"
    }
  }

  actions {
    job_name = aws_glue_job.raw_etl.name
  }
}

# ----------------------------------------------------------------------------------------------
# AWS Glue Trigger - Trusted Crawler
# ----------------------------------------------------------------------------------------------
resource "aws_glue_trigger" "trusted_crawler" {
  name              = "${var.prefix}-trusted-crawler"
  type              = "CONDITIONAL"
  workflow_name     = aws_glue_workflow.this.name
  start_on_creation = false

  predicate {
    conditions {
      job_name = aws_glue_job.raw_etl.name
      state    = "SUCCEEDED"
    }
  }

  actions {
    crawler_name = aws_glue_crawler.trusted.name
  }
}
