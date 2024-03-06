provider "aws" {
  region = "us-east-1" # Specify your desired region
}

resource "random_string" "bucket_name" {
  length  = 8
  special = false
}

resource "aws_s3_bucket" "example_bucket" {
  bucket = "${random_string.bucket_name.result}"

  # You can add additional configurations as needed
  acl    = "private"
}
