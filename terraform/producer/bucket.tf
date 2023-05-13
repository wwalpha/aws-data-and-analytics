# ----------------------------------------------------------------------------------------------
# S3 Bucket - Raw
# ----------------------------------------------------------------------------------------------
resource "aws_s3_bucket" "raw" {
  bucket = "${var.prefix}-${local.account_id}-raw"
}

# ----------------------------------------------------------------------------------------------
# S3 Bucket Object - Raw Dummy
# ----------------------------------------------------------------------------------------------
resource "aws_s3_object" "raw_dummy" {
  bucket = aws_s3_bucket.raw.id
  key    = "diabetic_data.csv"
  source = "${path.module}/datas/diabetic_data.csv"
  etag   = filemd5("${path.module}/datas/diabetic_data.csv")
}

# ----------------------------------------------------------------------------------------------
# S3 Bucket Ownership Control - Raw
# ----------------------------------------------------------------------------------------------
resource "aws_s3_bucket_ownership_controls" "raw" {
  bucket = aws_s3_bucket.raw.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# ----------------------------------------------------------------------------------------------
# S3 Bucket ACL - Raw
# ----------------------------------------------------------------------------------------------
resource "aws_s3_bucket_acl" "raw" {
  depends_on = [aws_s3_bucket_ownership_controls.raw]

  bucket = aws_s3_bucket.raw.id
  acl    = "private"
}

# ----------------------------------------------------------------------------------------------
# S3 Bucket Policy - Raw
# ----------------------------------------------------------------------------------------------
resource "aws_s3_bucket_policy" "raw_allow_access_from_central" {
  bucket = aws_s3_bucket.raw.id
  policy = data.aws_iam_policy_document.raw_allow_access_from_another_account.json
}

# # ----------------------------------------------------------------------------------------------
# # S3 Bucket - Trusted
# # ----------------------------------------------------------------------------------------------
# resource "aws_s3_bucket" "trusted" {
#   bucket = "${var.prefix}-${local.account_id}-trusted"
# }

# # ----------------------------------------------------------------------------------------------
# # S3 Bucket Ownership Control - Trusted
# # ----------------------------------------------------------------------------------------------
# resource "aws_s3_bucket_ownership_controls" "trusted" {
#   bucket = aws_s3_bucket.trusted.id
#   rule {
#     object_ownership = "BucketOwnerPreferred"
#   }
# }

# # ----------------------------------------------------------------------------------------------
# # S3 Bucket ACL - Trusted
# # ----------------------------------------------------------------------------------------------
# resource "aws_s3_bucket_acl" "trusted" {
#   depends_on = [aws_s3_bucket_ownership_controls.trusted]

#   bucket = aws_s3_bucket.trusted.id
#   acl    = "private"
# }

# # ----------------------------------------------------------------------------------------------
# # S3 Bucket Policy - Trusted
# # ----------------------------------------------------------------------------------------------
# resource "aws_s3_bucket_policy" "trusted_allow_access_from_central" {
#   bucket = aws_s3_bucket.trusted.id
#   policy = data.aws_iam_policy_document.trusted_allow_access_from_another_account.json
# }

# # ----------------------------------------------------------------------------------------------
# # S3 Bucket - Refined
# # ----------------------------------------------------------------------------------------------
# resource "aws_s3_bucket" "refined" {
#   bucket = "${var.prefix}-${local.account_id}-refined"
# }

# # ----------------------------------------------------------------------------------------------
# # S3 Bucket Ownership Control - Refined
# # ----------------------------------------------------------------------------------------------
# resource "aws_s3_bucket_ownership_controls" "refined" {
#   bucket = aws_s3_bucket.refined.id
#   rule {
#     object_ownership = "BucketOwnerPreferred"
#   }
# }

# # ----------------------------------------------------------------------------------------------
# # S3 Bucket ACL - Refined
# # ----------------------------------------------------------------------------------------------
# resource "aws_s3_bucket_acl" "refined" {
#   depends_on = [aws_s3_bucket_ownership_controls.refined]

#   bucket = aws_s3_bucket.refined.id
#   acl    = "private"
# }

# # ----------------------------------------------------------------------------------------------
# # S3 Bucket Policy - Refined
# # ----------------------------------------------------------------------------------------------
# resource "aws_s3_bucket_policy" "refined_allow_access_from_central" {
#   bucket = aws_s3_bucket.refined.id
#   policy = data.aws_iam_policy_document.refined_allow_access_from_another_account.json
# }
