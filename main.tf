

terraform {
  required_providers {
    terratowns ={
   source = "local.providers/local/terratowns"
    version = "1.0.0"
    } 
  }
}
provider "terratowns"{
  endpoint = "http://localhost:4567/api"
  user_uuid="e328f4ab-b99f-421c-84c9-4ccea042c7d1" 
  token="9b49b3fb-b8e9-483c-b703-97ba88eef8e0"
}
# module "terrahouse_aws" {
#   source = "./modules/terrahouse_aws"
#   UserUuid = var.UserUuid
#   bucket_Name = var.bucket_Name
#   index_html_filepath = var.index_html_filepath
#   error_html_filepath = var.error_html_filepath
#   content_version = var.content_version
#   assets_path = var.assets_path

# }


resource "terratowns_home" "home"{
  name = "Apex Legends!"
  description = <<Description
  Apex LEGENDS IS A GAME MADE BY EA, The game is set in the same universe as Respawn Entertainment's Titanfall series but does not feature the series' 
  signature Titans (large combat mechs). Instead, 
  Apex Legends focuses on squad-based gameplay and character-driven action.
  Description
  domain_name = "56646gcd.cloudfront.net"
  town = "gamers-grotto"
  content_version = 1
}
