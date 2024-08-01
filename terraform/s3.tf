
resource "aws_s3_bucket" "multiple_buckets" {
  for_each = toset(var.bucket_names)
  bucket = each.value
}


resource "aws_s3_bucket_public_access_block" "bucket1_private" {
  for_each = aws_s3_bucket.multiple_buckets
  bucket = each.value.bucket

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# resource "aws_s3_bucket" "artifact-store" {
#   bucket = var.bucket2_name
# }

# resource "aws_s3_bucket_public_access_block" "bucket2_private" {
#   bucket = aws_s3_bucket.artifact-store.id

#   block_public_acls       = true
#   block_public_policy     = true
#   ignore_public_acls      = true
#   restrict_public_buckets = true
# }