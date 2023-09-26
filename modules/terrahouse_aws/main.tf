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

