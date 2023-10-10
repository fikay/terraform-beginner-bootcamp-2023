## Terrahome Aws


```
module "terrahouse_aws2" {
  source = "./modules/terrahouse_aws"
  UserUuid = var.teacherseat_user_uuid
  bucket_Name = var.bucket_Name
  public_path = var.movies_public_path
  # index_html_filepath = var.index_html_filepath
  # error_html_filepath = var.error_html_filepath
  # assets_path = var.assets_path
  content_version = var.content_version
  

}

```


The ppublic directory expects the following
-index.html
-error.html
-assets


All top level assets in the assets directory will be copied, but not any subdirectories
