
resource "aws_s3_bucket" "model-store" {
    bucket = var.model_bucket_name
    
    tags = var.tags
    
}

resource "aws_s3_bucket_public_access_block" "model-store" {
  bucket = aws_s3_bucket.model-store.id

  block_public_acls = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true 
}

resource "aws_s3_bucket_ownership_controls" "model-store" {
  bucket = aws_s3_bucket.model-store.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}