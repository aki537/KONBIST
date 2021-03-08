resource "aws_s3_bucket" "kb_s3_bucket" {
  bucket = "kb-s3-bucket-for-images"
  acl ="public-read"
  
  tags = {
    Name = "kb-s3-bucket-for-images"
  }
}

resource "aws_s3_bucket" "kb_alb_log" {
  bucket = "artifact-terraform-for-kb"

  lifecycle_rule {
    enabled = true

    expiration {
      days = "180"
    }
  }
}