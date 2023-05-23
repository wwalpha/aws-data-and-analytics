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
