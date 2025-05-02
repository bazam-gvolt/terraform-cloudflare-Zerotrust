variable "account_id" {
  description = "Cloudflare Account ID"
  type        = string
}

variable "intune_client_id" {
  description = "Microsoft Intune Client ID for ZTNAPostureChecks app"
  type        = string
  default     = ""
}

variable "intune_client_secret" {
  description = "Microsoft Intune Client Secret"
  type        = string
  sensitive   = true
  default     = ""
}

variable "azure_tenant_id" {
  description = "Azure AD Tenant ID for Intune integration"
  type        = string
  default     = ""
}

# New variable for adding student identification
variable "student_id" {
  description = "Student identifier for educational environments"
  type        = string
  default     = "student"
}