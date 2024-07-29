
resource "aws_s3_bucket" "my-s3-bucket-2k24" {
  bucket = "my-tf-test-bucket"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}