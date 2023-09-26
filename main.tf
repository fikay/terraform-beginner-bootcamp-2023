

terraform {
  
}

module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  UserUuid = var.UserUuid
  bucket_Name = var.bucket_Name
}