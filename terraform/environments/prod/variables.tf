variable "account_id" {
  description = "Cloudflare Account ID"
  type        = string
}

variable "azure_client_id" {
  description = "Azure AD Client ID"
  type        = string
}

variable "azure_client_secret" {
  description = "Azure AD Client Secret"
  type        = string
  sensitive   = true
}

variable "azure_directory_id" {
  description = "Azure AD Directory ID (Tenant ID)"
  type        = string
}

variable "intune_client_id" {
  description = "Microsoft Intune Client ID for ZTNAPostureChecks app"
  type        = string
}

variable "intune_client_secret" {
  description = "Microsoft Intune Client Secret"
  type        = string
  sensitive   = true
}

variable "api_token" {
  description = "Cloudflare API Token with Zero Trust permissions"
  type        = string
  sensitive   = true
}

# Red team configuration
variable "red_team_name" {
  description = "Name for the red team access group"
  type        = string
  default     = "Red Team"
}

variable "red_team_group_ids" {
  description = "List of Azure AD group IDs for red team members"
  type        = list(string)
  default     = []
}

# Blue team configuration
variable "blue_team_name" {
  description = "Name for the blue team access group"
  type        = string
  default     = "Blue Team"
}

variable "blue_team_group_ids" {
  description = "List of Azure AD group IDs for blue team members"
  type        = list(string)
  default     = []
}

# Logging configuration
variable "enable_logs" {
  description = "Enable logging for analysis"
  type        = bool
  default     = false
}

variable "log_bucket" {
  description = "S3 bucket for storing logs"
  type        = string
  default     = "zero-trust-logs"
}