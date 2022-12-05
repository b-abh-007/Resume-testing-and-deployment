resource "aws_dynamodb_table" "test-ddb-table" {
  name           = "visitor-counter-table-2.0" #was: test-counter-table
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "visitor-counter"


  attribute {
    name = "visitor-counter"
    type = "S"
  }

}

resource "aws_dynamodb_table_item" "test-ddb-item" {
  table_name = aws_dynamodb_table.test-ddb-table.name
  hash_key   = aws_dynamodb_table.test-ddb-table.hash_key

  item = <<ITEM
{
"visitor-counter" : {"S": "resume-counter"},
"number" : {"N" : "0"}
}
ITEM
}

