terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}

resource "cloudflare_zero_trust_access_application" "app" {
  account_id  = var.account_id
  name        = var.app_name
  domain      = var.app_domain
  type        = "self_hosted"
}

resource "cloudflare_zero_trust_access_policy" "default_policy" {
  account_id     = var.account_id
  application_id = cloudflare_zero_trust_access_application.app.id
  name           = "Default Policy"
  precedence     = 1
  decision       = "allow"

  include {
    email = var.allowed_emails
  }
}