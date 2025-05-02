terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}

# Comment out the allow_all policy
# resource "cloudflare_zero_trust_gateway_policy" "allow_all" {
#   account_id  = var.account_id
#   name        = "Allow All Traffic"
#   description = "Allow all traffic through WARP"
#   precedence  = 1
#   action      = "allow"
#   filters     = ["dns"]
#   traffic     = "dns.type in {'A' 'AAAA' 'CNAME' 'TXT'}"
# }

resource "cloudflare_zero_trust_gateway_policy" "block_malware" {
  account_id  = var.account_id
  name        = "Block Malware"
  description = "Block known malware domains"
  precedence  = 2
  action      = "block"
  filters     = ["dns"]
  traffic     = "any(dns.content_category[*] in {80})"  # Corrected traffic expression
}

# Block Security Threats
resource "cloudflare_zero_trust_gateway_policy" "block_security_threats" {
  account_id  = var.account_id
  name        = "Block Security Threats"
  description = "Block all known security threats based on Cloudflare's threat intelligence"
  precedence  = 1
  action      = "block"
  filters     = ["dns"]
  
  # Using proper security category syntax
  traffic = "any(dns.security_category[*] in {80})"  # Security Threats category
}

resource "cloudflare_zero_trust_gateway_policy" "block_streaming" {
  account_id  = var.account_id
  name        = "Block Unauthorized Streaming"
  description = "Block unauthorized streaming platforms"
  precedence  = 2
  action      = "block"
  filters     = ["http"]
  
  # Use http.request.uri categories instead of application field
  traffic     = "any(http.request.uri.content_category[*] in {96})"  # 96 is streaming media category
}

resource "cloudflare_zero_trust_gateway_policy" "cipa_filter" {
  account_id  = var.account_id
  name        = "CIPA Content Filtering"
  description = "Block all websites that fall under CIPA filter categories"
  precedence  = 3
  action      = "block"
  filters     = ["dns", "http"]
  
  # Use array syntax for content categories
  traffic     = "any(http.request.uri.content_category[*] in {1 4 5 6 7})"
}

resource "cloudflare_zero_trust_access_application" "warp_enrollment_app" {
  account_id = var.account_id
  session_duration = "18h"
  name = "Warp device enrollment"
  allowed_idps = [var.azure_ad_provider_id]
  auto_redirect_to_identity = true
  type = "warp"
  app_launcher_visible = false
}

resource "cloudflare_zero_trust_access_policy" "warp_enrollment_policy" {
  application_id = cloudflare_zero_trust_access_application.warp_enrollment_app.id
  account_id = var.account_id
  name = "Allow Security Teams"
  decision = "allow"
  precedence = 1
  
  include {
    azure {
      id = ["a3008467-e39c-43f6-a7ad-4769bcefe01e", "5a071d2a-8597-4096-a6b3-1d702cfab3c4"]
      identity_provider_id = var.azure_ad_provider_id
    }
  }
}

# Added security_teams

resource "cloudflare_zero_trust_gateway_policy" "block_all_securityrisks" {
  account_id  = var.account_id
  name        = "Block_all_securityrisks_known_for_Cloudflare"
  description = "Block known threats"
  precedence  = 1
  action      = "block"
  filters     = ["dns"]
  
  # Simplified traffic expression to start with
  traffic     = "any(dns.security_category[*] in {4 7 9})"
  
  # Remove identity condition for now - we'll add it once we get the basic policy working
}

resource "cloudflare_zero_trust_gateway_policy" "block_file_uploads_unapproved_apps" {
  account_id  = var.account_id
  name        = "Block_file_uploads_to_Unapproved_Applications"
  description = "Block file uploads of specific types"
  precedence  = 2
  action      = "block"
  filters     = ["http"]
  
  # Using matches operator instead of contains
  traffic     = "http.request.uri matches \".*upload.*\""
}