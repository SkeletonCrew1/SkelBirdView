resource "aws_s3_bucket" "main" {
  bucket = "skeleton-crew-terraform-state-s3-bucket"

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