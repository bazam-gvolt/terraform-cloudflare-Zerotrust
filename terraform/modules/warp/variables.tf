variable "account_id" {
  description = "Cloudflare Account ID"
  type        = string
}

variable "warp_name" {
  description = "Name for the WARP configuration"
  type        = string
  default     = "Default WARP Configuration"
}

variable "azure_ad_provider_id" {
  description = "ID of the Azure AD identity provider created in Cloudflare"
  type        = string
}
variable "security_teams_id" {
  description = "ID of the security teams access group"
  type        = string
  default     = ""
}