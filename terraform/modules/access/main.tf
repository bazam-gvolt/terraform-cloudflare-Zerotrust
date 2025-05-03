terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}

# In access/main.tf
resource "cloudflare_zero_trust_access_application" "app" {
  account_id              = var.account_id
  name                    = var.app_name
  domain                  = var.app_domain
  type                    = "self_hosted"
  
  # Add session configurations
  session_duration      = "24h"
  app_launcher_visible  = true
  
  # Either add allowed_idps or remove auto_redirect
  # allowed_idps         = ["your-idp-id-here"]
  # auto_redirect_to_identity = true
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

# Add team-specific policies
resource "cloudflare_zero_trust_access_policy" "red_team_policy" {
  account_id     = var.account_id
  application_id = cloudflare_zero_trust_access_application.app.id
  name           = "Red Team Access"
  precedence     = 1  # Higher priority than email policy
  decision       = "allow"

  include {
    group = ["${var.account_id}/${var.red_team_name}"]
  }
}