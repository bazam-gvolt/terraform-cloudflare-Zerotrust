# terraform/modules/idp/main.tf
terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = ">=4.40.0"
    }
  }
}

resource "cloudflare_zero_trust_access_identity_provider" "microsoft_entra_id" {
  account_id = var.account_id
  name       = "Microsoft Entra ID"
  type       = "azureAD"
  config {
    client_id      = var.azure_client_id
    client_secret  = var.azure_client_secret
    directory_id   = var.azure_directory_id
    support_groups = true
    claims         = ["email", "profile", "groups"]
  }
}

# Red Team Access Group
resource "cloudflare_zero_trust_access_group" "red_team" {
  account_id = var.account_id
  name       = var.red_team_name
  
  include {
    azure {
      id = var.red_team_group_ids
      identity_provider_id = cloudflare_zero_trust_access_identity_provider.microsoft_entra_id.id
    }
  }
}

# Blue Team Access Group
resource "cloudflare_zero_trust_access_group" "blue_team" {
  account_id = var.account_id
  name       = var.blue_team_name
  
  include {
    azure {
      id = var.blue_team_group_ids
      identity_provider_id = cloudflare_zero_trust_access_identity_provider.microsoft_entra_id.id
    }
  }
}