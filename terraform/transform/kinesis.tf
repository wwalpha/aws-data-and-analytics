resource "aws_kinesis_stream" "this" {
  name             = "${var.prefix}-datastream"
  retention_period = 48
  encryption_type  = "KMS"
  kms_key_id       = "alias/aws/kinesis"

  stream_mode_details {
    stream_mode = "ON_DEMAND"
  }

  shard_level_metrics = ["IncomingBytes", "OutgoingBytes"]
}
