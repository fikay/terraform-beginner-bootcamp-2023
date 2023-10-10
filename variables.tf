variable "teacherseat_user_uuid" {
  type        = string
}

variable "terratowns_access_token" {
  type        = string
}

variable "bucket_Name" {
  type        = string
}

variable "index_html_filepath" {
  type        = string
}

variable "error_html_filepath" {
  type        = string
}

variable "content_version" {
  type        = number
}

variable "movies_content_version" {
  type        = number
}

variable "gaming_content_version" {
  type        = number
}

variable "assets_path" {
  type = string
  
}

variable "terratowns_endpoint" {
   type = string
}

variable "Apex_public_path" {
   type = string
}

variable "movies_public_path" {
   type = string
}

variable "movies" {
  type = object({
     public_path= string,
     content_version = number
  }) 
}

variable "gaming" {
  type = object({
     public_path= string,
     content_version = number
  }) 
}