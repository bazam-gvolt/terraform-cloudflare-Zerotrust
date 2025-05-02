# In environments/prod/main.tf
terraform {
  cloud {
    organization = "StartupWorks"
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
}

# Global Zero Trust configuration
resource "cloudflare_zero_trust_gateway_settings" "zero_trust" {
  account_id = var.account_id
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
  warp_name  = "Prod WARP Configuration"
  azure_ad_provider_id = module.idp.entra_idp_id
  security_teams_id = module.idp.security_teams_id
  depends_on = [cloudflare_zero_trust_gateway_settings.zero_trust, module.idp]
}

module "gateway" {
  source = "../../modules/gateway"
  account_id    = var.account_id
  location_name = "Prod Gateway"
  networks      = ["192.168.1.0/24"]
  depends_on    = [cloudflare_zero_trust_gateway_settings.zero_trust]
}

module "access" {
  source = "../../modules/access"
  account_id     = var.account_id
  app_name       = "StartupWorks"
  app_domain     = "app.StartupWorks.io"  # Replace with a domain you own in Cloudflare
  allowed_emails = ["user@StartupWorks.io"]
  depends_on     = [cloudflare_zero_trust_gateway_settings.zero_trust]
}

module "idp" {
  source = "../../modules/idp"
  account_id          = var.account_id
  azure_client_id     = var.azure_client_id
  azure_client_secret = var.azure_client_secret
  azure_directory_id  = var.azure_directory_id
  depends_on = [cloudflare_zero_trust_gateway_settings.zero_trust]
}