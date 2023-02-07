# ----------------------------------------------------------------------------------------------
# AWS Role - IoT Rule
# ----------------------------------------------------------------------------------------------
resource "aws_iam_role" "iot_rule" {
  name               = "${var.prefix}_IoTRuleRole"
  assume_role_policy = data.aws_iam_policy_document.iot.json

  lifecycle {
    create_before_destroy = false
  }
}
