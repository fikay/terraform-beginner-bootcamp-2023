

terraform {
  cloud {
    organization = "FaksOrg"

    workspaces {
      name = "terra-house-Apex-legends"
    }
  }
  required_providers {
    terratowns ={
   source = "local.providers/local/terratowns"
    version = "1.0.0"
    }
     random = {
      source = "hashicorp/random"
      version = "3.5.1"
    }
  }
}
provider "terratowns"{
  endpoint = var.terratowns_endpoint
  user_uuid=var.teacherseat_user_uuid
  token=var.terratowns_access_token
}



resource "random_string" "bucket_name" {
 length           = 32
  special          = false
  upper = false
}

module "terrahouse_aws1" {
  source = "./modules/terrahouse_aws"
  UserUuid = var.teacherseat_user_uuid
  bucket_Name = random_string.bucket_name.result
  public_path = var.gaming.public_path
  # index_html_filepath = var.index_html_filepath
  # error_html_filepath = var.error_html_filepath
  # assets_path = var.assets_path
  content_version = var.gaming.content_version
}


resource "terratowns_home" "home_game"{
  name = "Apex Legends!"
  description = <<Description
  Apex LEGENDS IS A GAME MADE BY EA, The game is set in the same universe as Respawn Entertainment's Titanfall series but does not feature the series' 
  signature Titans (large combat mechs). Instead, 
  Apex Legends focuses on squad-based gameplay and character-driven action.
  Description
  domain_name = module.terrahouse_aws1.cloudfront_domain
  town = "gamers-grotto"
  content_version = var.gaming.content_version
}

resource "random_string" "bucket_name2" {
  length           = 32
  special          = false
  upper = false
}

module "terrahouse_aws2" {
  source = "./modules/terrahouse_aws"
  UserUuid = var.teacherseat_user_uuid
  bucket_Name = random_string.bucket_name2.result
  public_path = var.movies.public_path
  # index_html_filepath = var.index_html_filepath
  # error_html_filepath = var.error_html_filepath
  # assets_path = var.assets_path
  content_version = var.movies.content_version
  

}

resource "terratowns_home" "home_movies"{
  name = "Top Series and Movies to Watch"
  description = <<Description
  Bored and do not know what to watch, don't be bored for long come inot my house and lets watch some amazing movies together!
  Description
  domain_name = module.terrahouse_aws2.cloudfront_domain
  town = "video-valley"
  content_version = var.movies.content_version
}