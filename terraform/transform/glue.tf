# ----------------------------------------------------------------------------------------------
# AWS Glue Catalog Database
# ----------------------------------------------------------------------------------------------
resource "aws_glue_catalog_database" "this" {
  name = "${var.prefix}-database"
}

# ----------------------------------------------------------------------------------------------
# AWS Glue Catalog Database Table
# ----------------------------------------------------------------------------------------------
resource "aws_glue_catalog_table" "this" {
  name          = "${var.prefix}-table"
  database_name = aws_glue_catalog_database.this.name
  table_type    = "EXTERNAL_TABLE"

  parameters = {
    classification = "json"
  }

  storage_descriptor {
    location      = aws_kinesis_stream.this.name
    input_format  = "org.apache.hadoop.mapred.TextInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"

    ser_de_info {
      serialization_library = "org.openx.data.jsonserde.JsonSerDe"

      parameters = {
        streamARN  = aws_kinesis_stream.this.arn
        typeOfData = "kinesis"
      }
    }
  }
}
