# ----------------------------------------------------------------------------------------------
# IAM Policy - AmazonSSMDirectoryServiceAccess
# ----------------------------------------------------------------------------------------------
data "aws_iam_policy" "ssm_directory_service_access" {
  name = "AmazonSSMDirectoryServiceAccess"
}

# ----------------------------------------------------------------------------------------------
# IAM Policy - AWSLambdaBasicExecutionRole
# ----------------------------------------------------------------------------------------------
data "aws_iam_policy" "lambda_basic_execution" {
  name = "AWSLambdaBasicExecutionRole"
}

# ----------------------------------------------------------------------------------------------
# IAM Policy - AWSLakeFormationCrossAccountManager
# ----------------------------------------------------------------------------------------------
data "aws_iam_policy" "lake_formation_cross_account_manager" {
  name = "AWSLakeFormationCrossAccountManager"
}

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
          "${aws_sfn_state_machine.this.arn}"
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

# ----------------------------------------------------------------------------------------------
# IAM Policy - Lambda Share Catalog Item
# ----------------------------------------------------------------------------------------------
resource "aws_iam_policy" "lambda_share_catalog_item" {
  name = "inline_policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "lakeformation:GrantPermissions",
          "glue:GetTable",
          "glue:GetDatabase"
        ]
        Resource = "*"
      }
    ]
  })
}

# ----------------------------------------------------------------------------------------------
# IAM Policy - Lambda Send Approval Notify
# ----------------------------------------------------------------------------------------------
resource "aws_iam_policy" "lambda_send_approval_notify" {
  name = "inline_policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "sts:AssumeRole",
        ]
        Resource = "arn:aws:iam::*:role/ProducerWorkflowRole"
      }
    ]
  })
}

# ----------------------------------------------------------------------------------------------
# IAM Policy - Lambda Get Table Details
# ----------------------------------------------------------------------------------------------
resource "aws_iam_policy" "lambda_get_table_details" {
  name = "inline_policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "glue:GetTable",
          "glue:GetDatabase"
        ]
        Resource = "*"
      }
    ]
  })
}

# ----------------------------------------------------------------------------------------------
# IAM Policy - Lambda Activity Approver
# ----------------------------------------------------------------------------------------------
resource "aws_iam_policy" "lambda_activity_approver" {
  name = "inline_policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "states:SendTaskSuccess",
          "states:SendTaskFailure"
        ]
        Resource = "*"
      }
    ]
  })
}
