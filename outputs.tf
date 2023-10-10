output "bucket_Name" {
  description = "Bucket name for our static website hosting"
  value = module.terrahouse_aws1.bucket_Name
}

output "website_endpoint" {
  description = "Url for our static website hosting"
  value = module.terrahouse_aws1.website_endpoint
}

output "domain_name" {
  description = "Cloudfront domain Name"
  value = module.terrahouse_aws1.cloudfront_domain
}