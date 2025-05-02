variable "account_id" {
  description = "Cloudflare Account ID"
  type        = string
}

variable "api_token" {
  description = "Cloudflare API Token"
  type        = string
  sensitive   = true
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