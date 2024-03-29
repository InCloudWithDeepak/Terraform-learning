# provider 
# aws_s3_bucket
# aws_s3_bucket_public_access_block
# aws_s3_bucket_ownership_controls
# aws_s3_bucket_acl
# aws_s3_object
# aws_s3_bucket_website_configuration

provider "aws" {
  region = "us-east-1"
  
}

resource "aws_s3_bucket" "s3" {
  bucket = "107-bucks"
  
}

resource "aws_s3_bucket_public_access_block" "s3-public-block" {
  bucket = aws_s3_bucket.s3.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_ownership_controls" "s3-ownership" {
  bucket = aws_s3_bucket.s3.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "s3-acl" {

  bucket = aws_s3_bucket.s3.id
  acl    = "public-read"
}

resource "aws_s3_object" "s3-object" {
  bucket = aws_s3_bucket.s3.id
  key    = "index.html"
  source = "index.html"
  content_type = "text/html"
  acl = "public-read"

}


resource "aws_s3_bucket_website_configuration" "s3-website" {
  bucket = aws_s3_bucket.s3.id

  index_document {
    suffix = "index.html"
  }
}