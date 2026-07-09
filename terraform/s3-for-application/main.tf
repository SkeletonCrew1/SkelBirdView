resource "aws_s3_bucket" "main" {
  bucket = "skeleton-crew-bucket-for-flask-application"

  tags = {
    ManagedBy = "Terraform"
  }
}

resource "aws_s3_bucket_versioning" "main" {
  bucket = aws_s3_bucket.main.id
  versioning_configuration {
    status = "Enabled"
  }
}