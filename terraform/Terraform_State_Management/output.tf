output "s3_bucket_name" {
  value = aws_s3_bucket.my_bucket.bucket
}

output "s3_bucket_arn" {
  value = aws_s3_bucket.my_bucket.arn
}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.basic-dynamodb-table.name
}

output "dynamodb_table_arn" {
  value = aws_dynamodb_table.basic-dynamodb-table.arn
}