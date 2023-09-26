variable "UserUuid" {
  type        = string
  description = "The UUID of the user."

  validation {
    condition     = can(regex("^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$", var.UserUuid))
    error_message = "UserUuid must be a valid UUID format (e.g., 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx')."
  }
}

variable "bucket_Name" {
  type        = string
  description = "An example string variable with validation"

  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9.-]{1,61}[a-z0-9]$", var.bucket_Name))
    error_message = "The 'example_string' variable must not be an empty string."
  }
}

variable "index_html_filepath" {
  type        = string
  description = "Path to the index.html file"

  validation {
    condition     = fileexists(var.index_html_filepath)
    error_message = "The specified 'index_html_filepath' does not exist or is not a valid file path."
  }
}


variable "error_html_filepath" {
  type        = string
  description = "Path to the error.html file"

  validation {
    condition     = fileexists(var.error_html_filepath)
    error_message = "The specified 'error_html_filepath' does not exist or is not a valid file path."
  }
}