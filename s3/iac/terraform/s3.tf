resource "aws_s3_bucket" "my-bucket-example-2000" {
  bucket = "my-tf-test-bucket"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}