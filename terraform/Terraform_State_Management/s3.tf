resource "aws_s3_bucket" "my_bucket" {

  bucket = "tanmay-unique-terraform-bucket-2026"

  tags = {
    Name        = "tanmay-unique-terraform-bucket-2026"
    Environment = "Dev"
  }

}

resource "aws_s3_bucket_versioning" "versioning" {

  bucket = aws_s3_bucket.my_bucket.id

  versioning_configuration {
    status = "Enabled"
  }

}