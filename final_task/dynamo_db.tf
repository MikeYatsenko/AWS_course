resource "aws_dynamodb_table" "edu-lohika-training-aws-dynamodb" {
  name           = var.dynamodb_table_name
  hash_key       = "UserName"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20

  attribute {
    name = "UserName"
    type = "S"
  }
}