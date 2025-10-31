#S3 Bucket Configuration
resource "aws_s3_bucket" "bucket" {
  bucket        = var.bucket_name
  force_destroy = true # Allow deletion of non-empty buckets, in production consider setting to false
  tags          = local.tags
}

resource "aws_s3_bucket_ownership_controls" "this" {
  bucket = aws_s3_bucket.bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

# S3 Bucket EventBridge Notification on all events to default bus
resource "aws_s3_bucket_notification" "eventbridge" {
  bucket      = aws_s3_bucket.bucket.id
  eventbridge = true

  depends_on = [
    aws_s3_bucket_ownership_controls.this,
    aws_s3_bucket_public_access_block.this
  ]

}