# --------------------------------------------------------------------------------------------------------------
# Amazon Cognito User Pool
# --------------------------------------------------------------------------------------------------------------
resource "aws_cognito_user_pool" "this" {
  name                     = "${var.prefix}_user_pool"
  auto_verified_attributes = ["email"]
  mfa_configuration        = "OFF"

  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }
    recovery_mechanism {
      name     = "verified_phone_number"
      priority = 2
    }
  }

  admin_create_user_config {
    allow_admin_create_user_only = false
  }

  schema {
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = true
    name                     = "email"
    required                 = true

    string_attribute_constraints {
      max_length = "2048"
      min_length = "0"
    }
  }

  user_attribute_update_settings {
    attributes_require_verification_before_update = [
      "email",
    ]
  }

  username_configuration {
    case_sensitive = false
  }
}

# -------------------------------------------------------
# Amazon Cognito User Pool Client - Web Client
# -------------------------------------------------------
resource "aws_cognito_user_pool_client" "web" {
  name         = "${var.prefix}_app_clientWeb"
  user_pool_id = aws_cognito_user_pool.this.id

  token_validity_units {
    refresh_token = "days"
  }
}

# -------------------------------------------------------
# Amazon Cognito User Pool Client - Client
# -------------------------------------------------------
resource "aws_cognito_user_pool_client" "this" {
  name         = "${var.prefix}_app_client"
  user_pool_id = aws_cognito_user_pool.this.id

  token_validity_units {
    refresh_token = "days"
  }
}

# --------------------------------------------------------------------------------------------------------------
# Amazon Cognito Identity Pool
# --------------------------------------------------------------------------------------------------------------
resource "aws_cognito_identity_pool" "this" {
  identity_pool_name = "${var.prefix}_identity_pool"

  cognito_identity_providers {
    client_id               = aws_cognito_user_pool_client.web.id
    provider_name           = aws_cognito_user_pool.this.endpoint
    server_side_token_check = false
  }

  cognito_identity_providers {
    client_id               = aws_cognito_user_pool_client.this.id
    provider_name           = aws_cognito_user_pool.this.endpoint
    server_side_token_check = false
  }
}

# --------------------------------------------------------------------------------------------------------------
# Amazon Cognito Identity Pool Role Attachment
# --------------------------------------------------------------------------------------------------------------
resource "aws_cognito_identity_pool_roles_attachment" "this" {
  identity_pool_id = aws_cognito_identity_pool.this.id

  roles = {
    "authenticated"   = aws_iam_role.cognito_auth_role.arn
    "unauthenticated" = aws_iam_role.cognito_unauth_role.arn
  }
}
