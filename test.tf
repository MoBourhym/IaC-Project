provider "aws" {
  region = "us-east-1"
  # Use environment variables or AWS CLI configuration for authentication
  # AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY environment variables will be used
}

resource "aws_s3_bucket" "my_test_bucket" {
  bucket = "my-unique-bucket-name-123456"
  # Note: 'acl' attribute is deprecated, use aws_s3_bucket_acl resource instead
}