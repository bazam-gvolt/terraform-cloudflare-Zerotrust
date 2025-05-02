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