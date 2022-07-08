##################################
# S3 service
#################################

resource "aws_s3_bucket" "website" {
  bucket = "anotherbuginthecode-deploy-vuejs-app-s3-cloudfront"
}

resource "aws_s3_bucket_acl" "website" {
  bucket = aws_s3_bucket.website.id
  acl = "private"
}

resource "aws_s3_bucket_versioning" "websicte" {
  bucket = aws_s3_bucket.website.id
  versioning_configuration {
    status = "Disabled"
  }
}

resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.website.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

  # (Optional) routing rules configuration... 
}


resource "aws_s3_bucket_cors_configuration" "website" {
  bucket = aws_s3_bucket.website.bucket

# enable CORS on PUT and POST request
#   cors_rule {
#     allowed_headers = ["*"]
#     allowed_methods = ["PUT", "POST"]
#     allowed_origins = ["<ALLOWED_ORIGINS_LIST>"]
#     expose_headers  = ["ETag"]
#     max_age_seconds = 3000
#   }

  cors_rule {
    allowed_methods = ["GET"]
    allowed_origins = ["*"]
  }

}


# attach policy to OAI to allow ONLY s3:GetObject permission
data "aws_iam_policy_document" "s3_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.website.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn]
    }
  }

  depends_on = [
    aws_cloudfront_origin_access_identity.origin_access_identity
  ]
}

resource "aws_s3_bucket_policy" "website" {
  bucket = aws_s3_bucket.website.id
  policy = data.aws_iam_policy_document.s3_policy.json

  depends_on = [
    data.aws_iam_policy_document.s3_policy
  ]
}

resource "aws_s3_bucket_public_access_block" "website" {
  bucket = aws_s3_bucket.website.id

  block_public_acls       = true
  block_public_policy     = true
  //ignore_public_acls      = true
  //restrict_public_buckets = true
}

output "bucket_name" {
  value = aws_s3_bucket.website.id
}