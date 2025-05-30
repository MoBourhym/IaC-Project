provider "aws" {
  region     = "us-east-1"
  access_key = "YOUR_ACCESS_KEY"
  secret_key = "YOUR_SECRET_KEY"
}


resource "aws_s3_bucket" "my_test_bucket" {
  bucket = "my-unique-bucket-name-123456"
  acl    = "private"
}