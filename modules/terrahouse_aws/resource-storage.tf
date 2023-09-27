resource "aws_s3_bucket" "website_Bucket" {
  # Bucket Naming Coonventions
  # https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html?icmpid=docs_amazons3_console
  bucket = var.bucket_Name

  tags = {
    UserUuid =var.UserUuid
  }

}

resource "aws_s3_bucket_website_configuration" "static_website" {
  bucket = aws_s3_bucket.website_Bucket.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}


resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.website_Bucket.bucket
  key    = "index.html"         # Specify the key (path) in the bucket
  source = var.index_html_filepath
  content_type = "text/html"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5(var.index_html_filepath)
  lifecycle {
    replace_triggered_by = [terraform_data.content_version.output]
    ignore_changes = [etag]
  }
}

resource "aws_s3_object" "error_html" {
  bucket = aws_s3_bucket.website_Bucket.bucket
  key    = "error.html"         # Specify the key (path) in the bucket
  source = var.error_html_filepath
  content_type = "text/html"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5(var.error_html_filepath)
 }

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.website_Bucket.bucket
  #policy = data.aws_iam_policy_document.allow_access_from_another_account.json
 policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "AllowCloudFrontServicePrincipalReadOnly",
        Effect    = "Allow",
        Principal = {
          Service = "cloudfront.amazonaws.com"
        },
        Action    = "s3:GetObject",
        Resource  = "arn:aws:s3:::${aws_s3_bucket.website_Bucket.bucket}/*",
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = "arn:aws:cloudfront::${data.aws_caller_identity.current.account_id}:distribution/${aws_cloudfront_distribution.s3_distribution.id}"
          }
        }
      }
    ]
  })
}

resource "terraform_data" "content_version" {
  input = var.content_version
}