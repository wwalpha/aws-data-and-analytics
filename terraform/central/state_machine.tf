# ----------------------------------------------------------------------------------------------
# State Machine
# ----------------------------------------------------------------------------------------------
resource "aws_sfn_state_machine" "this" {
  name     = "${var.prefix}-state-machine"
  role_arn = aws_iam_role.sfn.arn

  definition = <<EOF
{
  "Comment": "A Hello World example of the Amazon States Language using an AWS Lambda Function",
  "StartAt": "HelloWorld",
  "States": {
    "HelloWorld": {
      "Type": "Task",
      "Resource": "arn:aws:lambda:ap-northeast-1:334678299258:function:pkc-rsi",
      "End": true
    }
  }
}
EOF
}
