# Add to terraform/modules/warp/variables.tf
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

variable "red_team_group_ids" {
  description = "List of Azure AD group IDs for Red Team members"
  type        = list(string)
  default     = []
}

variable "blue_team_group_ids" {
  description = "List of Azure AD group IDs for Blue Team members"
  type        = list(string)
  default     = []
}

variable "azure_group_ids" {
  description = "List of Azure AD Group IDs for security access"
  type        = list(string)
  default     = ["00000000-0000-0000-0000-000000000000"] # Default placeholder
}