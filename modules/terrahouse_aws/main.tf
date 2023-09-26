terraform {
#   cloud {
#     organization = "FaksOrg"

#     workspaces {
#       name = "terra-house-1"
#     }
#   }
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.17.0"
    }
  }
}

# provider "aws" {
#   # Configuration options
# }
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
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

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5(var.index_html_filepath)
}

resource "aws_s3_object" "error_html" {
  bucket = aws_s3_bucket.website_Bucket.bucket
  key    = "error.html"         # Specify the key (path) in the bucket
  source = var.error_html_filepath

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5(var.error_html_filepath)
}