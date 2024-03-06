provider "aws" {
  region = "us-east-1" # Specify your desired region
}

resource "aws_s3_bucket" "example_bucket" {
  bucket = "valid-bucket-name-hemaraj-009"
  # Additional configuration options...
}
