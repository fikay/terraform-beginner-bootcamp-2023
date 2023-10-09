

terraform {
  required_providers {
    terratowns ={
   source = "local.providers/local/terratowns"
    version = "1.0.0"
    } 
  }
}
provider "terratowns"{
  endpoint = var.terratowns_endpoint
  user_uuid=var.teacherseat_user_uuid
  token=var.terratowns_access_token
}
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  UserUuid = var.teacherseat_user_uuid
  bucket_Name = var.bucket_Name
  index_html_filepath = var.index_html_filepath
  error_html_filepath = var.error_html_filepath
  content_version = var.content_version
  assets_path = var.assets_path

}


resource "terratowns_home" "home"{
  name = "Apex Legends!"
  description = <<Description
  Apex LEGENDS IS A GAME MADE BY EA, The game is set in the same universe as Respawn Entertainment's Titanfall series but does not feature the series' 
  signature Titans (large combat mechs). Instead, 
  Apex Legends focuses on squad-based gameplay and character-driven action.
  Description
  domain_name = module.terrahouse_aws.cloudfront_domain
  town = "gamers-grotto"
  content_version = 1
}
