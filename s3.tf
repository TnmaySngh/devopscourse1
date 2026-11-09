resource "aws_s3_bucket" "my_bucket" {

  bucket = "my-unique-bucket-name-12345-tanmay"

  tags = {
    Name        = "My S3 Bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_versioning" "versioning" {

  bucket = aws_s3_bucket.my_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}