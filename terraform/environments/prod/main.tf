# In environments/prod/main.tf
terraform {
  cloud {
    organization = "gvolt"
    workspaces {
      name = "terraform-cloudflare-Zerotrust"
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
  retries   = 3
}

# Global Zero Trust configuration
resource "cloudflare_zero_trust_gateway_settings" "zero_trust" {
  account_id = var.account_id
}

module "idp" {
  source = "../../modules/idp"
  account_id          = var.account_id
  azure_client_id     = var.azure_client_id
  azure_client_secret = var.azure_client_secret
  azure_directory_id  = var.azure_directory_id
  security_team_name  = var.security_team_name
  security_team_group_ids = var.security_team_group_ids
  depends_on = [cloudflare_zero_trust_gateway_settings.zero_trust]
}

module "device_posture" {
  source = "../../modules/device_posture"
  account_id = var.account_id
  intune_client_id = var.intune_client_id
  intune_client_secret = var.intune_client_secret
  azure_tenant_id = var.azure_directory_id
  depends_on = [cloudflare_zero_trust_gateway_settings.zero_trust]
}

module "warp" {
  source = "../../modules/warp"
  account_id = var.account_id
  # Use Terraform workspace name for uniqueness
  warp_name  = "WARP-${terraform.workspace}"
  azure_ad_provider_id = module.idp.entra_idp_id
  security_teams_id = module.idp.security_teams_id
  azure_group_ids = var.security_team_group_ids
  depends_on = [cloudflare_zero_trust_gateway_settings.zero_trust, module.idp]
}

module "gateway" {
  source = "../../modules/gateway"
  account_id    = var.account_id
  location_name = "Gateway-${terraform.workspace}"
  networks      = ["192.168.1.0/24"]
  depends_on    = [cloudflare_zero_trust_gateway_settings.zero_trust]
}

module "access" {
  source = "../../modules/access"
  account_id     = var.account_id
  app_name       = "StartupWorks-${terraform.workspace}"
  app_domain     = "app-${terraform.workspace}.example.com"
  allowed_emails = ["user@StartupWorks.io"]
  depends_on     = [cloudflare_zero_trust_gateway_settings.zero_trust]
}