resource "aws_s3_bucket" "my-bucket-example-2000" {
  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}