variable "account_id" {
  description = "Cloudflare Account ID"
  type        = string
}

variable "app_name" {
  description = "Access Application Name"
  type        = string
}

variable "app_domain" {
  description = "Application Domain"
  type        = string
}

variable "allowed_emails" {
  description = "List of allowed email addresses"
  type        = list(string)
  default     = []
}