terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"  # Keep at version 4
    }
  }
}

resource "cloudflare_zero_trust_access_application" "app" {
  account_id              = var.account_id
  name                    = var.app_name
  domain                  = var.app_domain
  type                    = "self_hosted"
  
  session_duration      = "24h"
  app_launcher_visible  = true
}

# Policy for email-based access
resource "cloudflare_zero_trust_access_policy" "email_policy" {
  account_id     = var.account_id
  application_id = cloudflare_zero_trust_access_application.app.id
  name           = "Email Access Policy"
  precedence     = 2
  decision       = "allow"

  include {
    email = var.allowed_emails
  }
}

# Fix the Red Team policy to use Azure directly
resource "cloudflare_zero_trust_access_policy" "red_team_policy" {
  account_id     = var.account_id
  application_id = cloudflare_zero_trust_access_application.app.id
  name           = "Red Team Access"
  precedence     = 1
  decision       = "allow"

  include {
    azure {
      id = var.red_team_group_ids
      identity_provider_id = var.account_id
    }
  }
}