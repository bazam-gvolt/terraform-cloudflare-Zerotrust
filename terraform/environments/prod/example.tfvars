# Example Terraform variables file
# Copy this to terraform.tfvars and update with your values

account_id          = "your-cloudflare-account-id"
api_token           = "your-cloudflare-api-token"
azure_client_id     = "your-azure-client-id"
azure_client_secret = "your-azure-client-secret"
azure_directory_id  = "your-azure-directory-id"
intune_client_id    = "your-intune-client-id" # Usually same as azure_client_id
intune_client_secret = "your-intune-client-secret" # Usually same as azure_client_secret

# Security team configuration
security_team_name = "Security Teams"
security_team_group_ids = [
  "00000000-0000-0000-0000-000000000000", # Replace with actual Azure AD group IDs
  "11111111-1111-1111-1111-111111111111"
]