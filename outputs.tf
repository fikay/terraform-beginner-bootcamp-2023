output "bucket_Name" {
  description = "Bucket name for our static website hosting"
  value = module.terrahouse_aws.bucket_Name
}

output "website_endpoint" {
  description = "Url for our static website hosting"
  value = module.terrahouse_aws.website_endpoint
}