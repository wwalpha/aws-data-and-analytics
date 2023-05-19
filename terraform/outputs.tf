# ----------------------------------------------------------------------------------------------
# Producer Bucket Name - Raw
# ----------------------------------------------------------------------------------------------
output "producer_bucket_name_raw" {
  value = module.producer.s3_bucket_name_raw
}

# ----------------------------------------------------------------------------------------------
# Producer Bucket Name - Scripts
# ----------------------------------------------------------------------------------------------
# output "producer_bucket_name_scripts" {
#   value = module.producer.s3_bucket_name_scripts
# }

# output "test" {
#   value = module.producer.test
# }

# # ----------------------------------------------------------------------------------------------
# # Producer Bucket Name - Refined
# # ----------------------------------------------------------------------------------------------
# output "producer_bucket_name_refined" {
#   value = module.producer.bucket_name_refined
# }

# # ----------------------------------------------------------------------------------------------
# # Producer Bucket Name - Trusted
# # ----------------------------------------------------------------------------------------------
# output "producer_bucket_name_trusted" {
#   value = module.producer.bucket_name_trusted
# }
