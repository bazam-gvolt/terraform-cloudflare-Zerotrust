# terraform/modules/idp/variables.tf
variable "account_id" {
  description = "Cloudflare Account ID"
  type        = string
}

variable "azure_client_id" {
  description = "Microsoft Entra ID Client ID"
  type        = string
}

variable "azure_client_secret" {
  description = "Microsoft Entra ID Client Secret"
  type        = string
  sensitive   = true
}

variable "azure_directory_id" {
  description = "Microsoft Entra ID Directory ID (Tenant ID)"
  type        = string
}

# Add these new variables
variable "security_team_name" {
  description = "Name for the security team access group"
  type        = string
  default     = "Security Teams"
}

variable "security_team_group_ids" {
  description = "List of Azure AD group IDs for security team members"
  type        = list(string)
  default     = ["00000000-0000-0000-0000-000000000000"] # Default placeholder
}