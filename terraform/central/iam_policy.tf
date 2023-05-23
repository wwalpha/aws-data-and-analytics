# ----------------------------------------------------------------------------------------------
# IAM Policy - Cognito Authenticated Policy
# ----------------------------------------------------------------------------------------------
resource "aws_iam_policy" "cognito_auth" {
  name = "cognito_authenticated"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "glue:GetDatabase",
          "glue:GetTables",
          "glue:GetDatabases",
          "glue:GetTable"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "states:ListExecutions",
          "states:StartExecution"
        ]
        Resource = [
          aws_sfn_state_machine.this.arn
        ],
      },
      {
        Effect = "Allow"
        Action = [
          "states:DescribeExecution",
        ]
        Resource = [
          "${aws_sfn_state_machine.this.arn}:*"
        ],
      }
    ]
  })
}
