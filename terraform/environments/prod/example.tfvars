# Example Terraform variables file
# Copy this to terraform.tfvars and update with your values

account_id          = "your-cloudflare-account-id"
api_token           = "your-cloudflare-api-token"
azure_client_id     = "your-azure-client-id"
azure_client_secret = "your-azure-client-secret"
azure_directory_id  = "your-azure-directory-id"
intune_client_id    = "your-intune-client-id" # Usually same as azure_client_id
intune_client_secret = "your-intune-client-secret" # Usually same as azure_client_secret

# Red team configuration
red_team_name = "Red Team"
red_team_group_ids = [
  "00000000-0000-0000-0000-000000000000" # Replace with actual Azure AD group IDs
]

# Blue team configuration
blue_team_name = "Blue Team"
blue_team_group_ids = [
  "11111111-1111-1111-1111-111111111111" # Replace with actual Azure AD group IDs
]