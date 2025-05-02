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

# New variables for security teams
variable "security_team_name" {
  description = "Name for the security team access group"
  type        = string
  default     = "Security Teams"
}

variable "security_team_group_ids" {
  description = "List of Azure AD group IDs for security team members"
  type        = list(string)
  default     = []
}