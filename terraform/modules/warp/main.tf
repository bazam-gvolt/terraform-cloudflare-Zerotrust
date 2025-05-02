terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}

resource "cloudflare_zero_trust_gateway_policy" "block_malware" {
  account_id  = var.account_id
  name        = "Block Malware"
  description = "Block known malware domains"
  precedence  = 2
  action      = "block"
  filters     = ["dns"]
  traffic     = "any(dns.content_category[*] in {80})"
}

# Block Security Threats
resource "cloudflare_zero_trust_gateway_policy" "block_security_threats" {
  account_id  = var.account_id
  name        = "Block Security Threats"
  description = "Block all known security threats based on Cloudflare's threat intelligence"
  precedence  = 1
  action      = "block"
  filters     = ["dns"]
  traffic     = "any(dns.security_category[*] in {80})"
}

resource "cloudflare_zero_trust_gateway_policy" "block_streaming" {
  account_id  = var.account_id
  name        = "Block Unauthorized Streaming"
  description = "Block unauthorized streaming platforms"
  precedence  = 2
  action      = "block"
  filters     = ["http"]
  traffic     = "any(http.request.uri.content_category[*] in {96})"
}

resource "cloudflare_zero_trust_gateway_policy" "cipa_filter" {
  account_id  = var.account_id
  name        = "CIPA Content Filtering"
  description = "Block all websites that fall under CIPA filter categories"
  precedence  = 3
  action      = "block"
  filters     = ["dns", "http"]
  traffic     = "any(http.request.uri.content_category[*] in {1 4 5 6 7})"
}

# WARP Enrollment Application with unique name - use workspace name for uniqueness
resource "cloudflare_zero_trust_access_application" "warp_enrollment_app" {
  account_id             = var.account_id
  session_duration       = "18h"
  name                   = "${var.warp_name} - Device Enrollment"
  allowed_idps           = [var.azure_ad_provider_id]
  auto_redirect_to_identity = true
  type                   = "warp"
  app_launcher_visible   = false
  
  # Add lifecycle to prevent destroy/recreate cycles
  lifecycle {
    create_before_destroy = true
  }
}

resource "cloudflare_zero_trust_access_policy" "warp_enrollment_policy" {
  application_id = cloudflare_zero_trust_access_application.warp_enrollment_app.id
  account_id     = var.account_id
  name           = "Allow Security Teams"
  decision       = "allow"
  precedence     = 1
  
  include {
    azure {
      id = var.azure_group_ids
      identity_provider_id = var.azure_ad_provider_id
    }
  }
}

resource "cloudflare_zero_trust_gateway_policy" "block_all_securityrisks" {
  account_id  = var.account_id
  name        = "Block_all_securityrisks_known_for_Cloudflare"
  description = "Block known threats"
  precedence  = 1
  action      = "block"
  filters     = ["dns"]
  traffic     = "any(dns.security_category[*] in {4 7 9})"
}

resource "cloudflare_zero_trust_gateway_policy" "block_file_uploads_unapproved_apps" {
  account_id  = var.account_id
  name        = "Block_file_uploads_to_Unapproved_Applications"
  description = "Block file uploads of specific types"
  precedence  = 2
  action      = "block"
  filters     = ["http"]
  traffic     = "http.request.uri matches \".*upload.*\""
}