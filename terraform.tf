terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

backend "s3" {
    bucket       = "tanmay-unique-terraform-bucket-2026"
    key          = "dev/terraform.tfstate"
    region       = "us-east-2"
    dynamodb_table = "Tanmay-DynamoDB-Table"
    encrypt      = true
    use_lockfile = true
  }

}