provider "aws" {
  region = "us-east-1"
}

# resource for creating a simple s3 bucket
resource "aws_s3_bucket" "S3" {
    bucket = "tf-s3-bucket-11218"
    tags = {
    }
}