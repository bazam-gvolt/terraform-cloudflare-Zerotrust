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

variable "red_team_name" {
  description = "Name of the Red Team group"
  type        = string
  default     = "Red Team"
}

variable "blue_team_name" {
  description = "Name of the Blue Team group"
  type        = string
  default     = "Blue Team"
}