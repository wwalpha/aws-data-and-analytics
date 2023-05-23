# ----------------------------------------------------------------------------------------------
# Lambda Function
# ----------------------------------------------------------------------------------------------
resource "aws_lambda_function" "send_approval_notify" {
  function_name    = "${var.prefix}-SendApprovalNotify"
  filename         = data.archive_file.lambda_default.output_path
  source_code_hash = data.archive_file.lambda_default.output_base64sha256
  handler          = "index.handler"
  memory_size      = 128
  role             = aws_iam_role.lambda_send_approval_notify.arn
  runtime          = "nodejs16.x"
  timeout          = 10


  environment {
    variables = {
      API_GATEWAY_BASE_URL = "https://j1573g4gg7.execute-api.ap-northeast-1.amazonaws.com/workflow"
    }
  }
}

# ----------------------------------------------------------------------------------------------
# Lambda Function
# ----------------------------------------------------------------------------------------------
resource "aws_lambda_function" "share_catalog_item" {
  function_name    = "${var.prefix}-SendApprovalNotify"
  filename         = data.archive_file.lambda_default.output_path
  source_code_hash = data.archive_file.lambda_default.output_base64sha256
  handler          = "index.handler"
  memory_size      = 128
  role             = aws_iam_role.lambda_share_catalog_item.arn
  runtime          = "nodejs16.x"
  timeout          = 10
}

# ----------------------------------------------------------------------------------------------
# Lambda Function
# ----------------------------------------------------------------------------------------------
resource "aws_lambda_function" "activity_approver" {
  function_name    = "${var.prefix}-ActivityApprover"
  filename         = data.archive_file.lambda_default.output_path
  source_code_hash = data.archive_file.lambda_default.output_base64sha256
  handler          = "index.handler"
  memory_size      = 128
  role             = aws_iam_role.lambda_activity_approver.arn
  runtime          = "nodejs16.x"
  timeout          = 10
}

# ---------------------------------------------------------------------------------------------
# API Gateway Permission
# ---------------------------------------------------------------------------------------------
# resource "aws_lambda_permission" "activity_approver" {
#   action        = "lambda:InvokeFunction"
#   function_name = aws_lambda_function.activity_approver.function_name
#   principal     = "apigateway.amazonaws.com"
#   source_arn    = "${aws_apigatewayv2_api.this.execution_arn}/*/*/workflow/update-state"
# }


# ----------------------------------------------------------------------------------------------
# Lambda Function
# ----------------------------------------------------------------------------------------------
resource "aws_lambda_function" "get_table_details" {
  function_name    = "${var.prefix}-GetTableDetails"
  filename         = data.archive_file.lambda_default.output_path
  source_code_hash = data.archive_file.lambda_default.output_base64sha256
  handler          = "index.handler"
  memory_size      = 128
  role             = aws_iam_role.lambda_get_table_details.arn
  runtime          = "nodejs16.x"
  timeout          = 10
}


# ----------------------------------------------------------------------------------------------
# Archive file - Lambda default module
# ----------------------------------------------------------------------------------------------
data "archive_file" "lambda_default" {
  type        = "zip"
  output_path = "${path.module}/dist/default.zip"

  source {
    content  = <<EOT
export const handler = async(event) => {
    console.log(event);
    // TODO implement
    const response = {
        statusCode: 200,
        body: JSON.stringify('Hello from Lambda!'),
    };
    return response;
};
EOT
    filename = "index.mjs"
  }
}
