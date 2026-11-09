resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = "Tanmay-DynamoDB-Table"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "Tanmay-DynamoDB-Table"
    Environment = "Dev"
  }
}
