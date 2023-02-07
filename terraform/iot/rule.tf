# ----------------------------------------------------------------------------------------------
# AWS IoT Topic Rule
# ----------------------------------------------------------------------------------------------
resource "aws_iot_topic_rule" "this" {
  name        = "${var.prefix}Rule"
  enabled     = true
  sql         = "SELECT * FROM '${var.prefix}/inputs'"
  sql_version = "2016-03-23"

  kinesis {
    stream_name = var.kinesis_data_stream_name
    role_arn    = var.iam_rule_arn_iot_rule
  }
}
