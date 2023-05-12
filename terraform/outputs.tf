# ----------------------------------------------------------------------------------------------
# Producer Bucket Name - Raw
# ----------------------------------------------------------------------------------------------
output "producer_bucket_name_raw" {
  value = module.producer.bucket_name_raw
}

# ----------------------------------------------------------------------------------------------
# Producer Bucket Name - Refined
# ----------------------------------------------------------------------------------------------
output "producer_bucket_name_refined" {
  value = module.producer.bucket_name_refined
}

# ----------------------------------------------------------------------------------------------
# Producer Bucket Name - Trusted
# ----------------------------------------------------------------------------------------------
output "producer_bucket_name_trusted" {
  value = module.producer.bucket_name_trusted
}
