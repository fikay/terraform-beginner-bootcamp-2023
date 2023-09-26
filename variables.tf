variable "UserUuid" {
  type        = string
  description = "The UUID of the user."

  validation {
    condition     = can(regex("^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$", var.UserUuid))
    error_message = "UserUuid must be a valid UUID format (e.g., 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx')."
  }
}
