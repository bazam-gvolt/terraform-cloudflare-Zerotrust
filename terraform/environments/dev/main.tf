terraform {
  cloud {
    organization = "reddome_academy"
    workspaces {
      name = "cloudflare-zerotrust-dev"
    }
  }

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}

provider "cloudflare" {
  api_token = var.api_token
}

module "warp" {
  source = "../../modules/warp"
  account_id = var.account_id
  warp_name  = "Dev WARP Configuration"
}

resource "cloudflare_zero_trust_access_identity_provider" "azure_ad" {
  account_id = var.account_id
  name       = "Azure AD"
  type       = "azureAD"
  config {
    client_id     = var.azure_client_id
    client_secret = var.azure_client_secret
    directory_id  = var.azure_directory_id
  }
}