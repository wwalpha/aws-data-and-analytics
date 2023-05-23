# ----------------------------------------------------------------------------------------------
# IAM Role - Glue Crawler
# ----------------------------------------------------------------------------------------------
resource "aws_iam_role" "glue_crawler" {
  name               = "${upper(var.prefix)}_GlueCrawlerRole"
  assume_role_policy = data.aws_iam_policy_document.glue.json
}

# ----------------------------------------------------------------------------------------------
# IAM Role - State Machine
# ----------------------------------------------------------------------------------------------
resource "aws_iam_role" "sfn" {
  name               = "${upper(var.prefix)}_StateMachineRole"
  assume_role_policy = data.aws_iam_policy_document.sfn.json
}

# ----------------------------------------------------------------------------------------------
# IAM Role - Cognito Authenticated Role
# ----------------------------------------------------------------------------------------------
resource "aws_iam_role" "cognito_auth_role" {
  name = "${upper(var.prefix)}_Cognito_AuthRole"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "cognito-identity.amazonaws.com"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "cognito-identity.amazonaws.com:aud": "${aws_cognito_identity_pool.this.id}"
        },
        "ForAnyValue:StringLike": {
          "cognito-identity.amazonaws.com:amr": "authenticated"
        }
      }
    }
  ]
}
EOF
}

# ----------------------------------------------------------------------------------------------
# IAM Role - Cognito Unauthenticated Role
# ----------------------------------------------------------------------------------------------
resource "aws_iam_role" "cognito_unauth_role" {
  name = "${upper(var.prefix)}_Cognito_UnauthRole"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "cognito-identity.amazonaws.com"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "cognito-identity.amazonaws.com:aud": "${aws_cognito_identity_pool.this.id}"
        },
        "ForAnyValue:StringLike": {
          "cognito-identity.amazonaws.com:amr": "unauthenticated"
        }
      }
    }
  ]
}
EOF
}

# ----------------------------------------------------------------------------------------------
# IAM Role - Lambda Send Approval Notify
# ----------------------------------------------------------------------------------------------
resource "aws_iam_role" "lambda_send_approval_notify" {
  name               = "${upper(var.prefix)}_SendApprovalNotityRole"
  assume_role_policy = data.aws_iam_policy_document.lambda.json
}

# ----------------------------------------------------------------------------------------------
# IAM Role Policy Attachment - Lambda Share Catalog Item
# ----------------------------------------------------------------------------------------------
resource "aws_iam_role_policy_attachment" "lambda_send_approval_notify_basic" {
  role       = aws_iam_role.lambda_send_approval_notify.name
  policy_arn = data.aws_iam_policy.lambda_basic_execution.arn
}

resource "aws_iam_role_policy_attachment" "lambda_send_approval_notify_inline" {
  role       = aws_iam_role.lambda_send_approval_notify.name
  policy_arn = aws_iam_policy.lambda_send_approval_notify.arn
}


# ----------------------------------------------------------------------------------------------
# IAM Role - Lambda Share Catalog Item
# ----------------------------------------------------------------------------------------------
resource "aws_iam_role" "lambda_share_catalog_item" {
  name               = "${upper(var.prefix)}_ShareCatalogItemRole"
  assume_role_policy = data.aws_iam_policy_document.lambda.json
}

# ----------------------------------------------------------------------------------------------
# IAM Role Policy Attachment - Lambda Share Catalog Item
# ----------------------------------------------------------------------------------------------
resource "aws_iam_role_policy_attachment" "lambda_share_catalog_item_basic" {
  role       = aws_iam_role.lambda_share_catalog_item.name
  policy_arn = data.aws_iam_policy.lambda_basic_execution.arn
}

resource "aws_iam_role_policy_attachment" "lambda_share_catalog_item_lake_formation_cross_account_manager" {
  role       = aws_iam_role.lambda_share_catalog_item.name
  policy_arn = data.aws_iam_policy.lake_formation_cross_account_manager.arn
}

resource "aws_iam_role_policy_attachment" "lambda_share_catalog_item_inline" {
  role       = aws_iam_role.lambda_share_catalog_item.name
  policy_arn = aws_iam_policy.lambda_share_catalog_item.arn
}

# ----------------------------------------------------------------------------------------------
# IAM Role - Lambda Activity Approver
# ----------------------------------------------------------------------------------------------
resource "aws_iam_role" "lambda_activity_approver" {
  name               = "${upper(var.prefix)}_ActivityApproverRole"
  assume_role_policy = data.aws_iam_policy_document.lambda.json
}

# ----------------------------------------------------------------------------------------------
# IAM Role Policy Attachment - Lambda Activity Approver
# ----------------------------------------------------------------------------------------------
resource "aws_iam_role_policy_attachment" "lambda_activity_approver_basic" {
  role       = aws_iam_role.lambda_activity_approver.name
  policy_arn = data.aws_iam_policy.lambda_basic_execution.arn
}

resource "aws_iam_role_policy_attachment" "lambda_activity_approver_inline" {
  role       = aws_iam_role.lambda_activity_approver.name
  policy_arn = aws_iam_policy.lambda_activity_approver.arn
}

# ----------------------------------------------------------------------------------------------
# IAM Role - Lambda Get Table Details
# ----------------------------------------------------------------------------------------------
resource "aws_iam_role" "lambda_get_table_details" {
  name               = "${upper(var.prefix)}_GetTableDetailsRole"
  assume_role_policy = data.aws_iam_policy_document.lambda.json
}

# ----------------------------------------------------------------------------------------------
# IAM Role Policy Attachment - Lambda Activity Approver
# ----------------------------------------------------------------------------------------------
resource "aws_iam_role_policy_attachment" "lambda_get_table_details_basic" {
  role       = aws_iam_role.lambda_get_table_details.name
  policy_arn = data.aws_iam_policy.lambda_basic_execution.arn
}

resource "aws_iam_role_policy_attachment" "lambda_get_table_details_inline" {
  role       = aws_iam_role.lambda_get_table_details.name
  policy_arn = aws_iam_policy.lambda_get_table_details.arn
}
