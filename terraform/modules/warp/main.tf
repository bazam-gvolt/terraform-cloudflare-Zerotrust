terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}

# Security blocks - using consolidated and properly prioritized rules
resource "cloudflare_zero_trust_gateway_policy" "consolidated_security_blocks" {
  account_id  = var.account_id
  name        = "Block All Security Threats"
  description = "Block all security threats and malware based on Cloudflare's threat intelligence"
  precedence  = 10  # Lower number = higher priority
  action      = "block"
  filters     = ["dns"]
  traffic     = "any(dns.security_category[*] in {4 7 9 80})"  # Consolidated security categories
}

# CIPA Content filtering - proper expression for both DNS and HTTP
resource "cloudflare_zero_trust_gateway_policy" "content_filtering" {
  account_id  = var.account_id
  name        = "Content Filtering Policy"
  description = "Block all websites that fall under CIPA filter categories"
  precedence  = 20
  action      = "block"
  filters     = ["dns", "http"]
  traffic     = "any(dns.content_category[*] in {1 4 5 6 7}) or any(http.request.uri.content_category[*] in {1 4 5 6 7})"
}

# Block streaming for standard users but allow for red team
resource "cloudflare_zero_trust_gateway_policy" "block_streaming" {
  account_id  = var.account_id
  name        = "Block Streaming except for Red Team"
  description = "Block unauthorized streaming platforms except for Red Team members"
  precedence  = 30
  action      = "block"
  filters     = ["http"]
  traffic     = "any(http.request.uri.content_category[*] in {96}) and not(cf.identity.groups in {\"${var.red_team_name}\"})"
}

# More targeted file upload blocking with exceptions
resource "cloudflare_zero_trust_gateway_policy" "block_file_uploads" {
  account_id  = var.account_id
  name        = "Block Unauthorized File Uploads"
  description = "Block file uploads to unauthorized services except for security teams"
  precedence  = 40
  action      = "block"
  filters     = ["http"]
  traffic     = "http.request.method == \"POST\" and http.request.uri matches \".*upload.*\" and not(http.request.uri matches \".*(sharepoint|onedrive|teams).*\") and not(cf.identity.groups in {\"${var.red_team_name}\"})"
}

# Special access rule for Red Team
resource "cloudflare_zero_trust_gateway_policy" "red_team_tools_allow" {
  account_id  = var.account_id
  name        = "Red Team Special Access"
  description = "Allow Red Team access to security testing tools"
  precedence  = 5  # Higher priority than blocking rules
  action      = "allow"
  filters     = ["http", "dns"]
  traffic     = "cf.identity.groups == \"${var.red_team_name}\" and (http.request.uri matches \".*security-tools.*\" or dns.domains in {\"kali.org\", \"metasploit.com\", \"hackerone.com\"})"
}

# Special access rule for Blue Team
resource "cloudflare_zero_trust_gateway_policy" "blue_team_tools_allow" {
  account_id  = var.account_id
  name        = "Blue Team Special Access"
  description = "Allow Blue Team access to security monitoring tools"
  precedence  = 6  # Priority just after Red Team access
  action      = "allow"
  filters     = ["http", "dns"]
  traffic     = "cf.identity.groups == \"${var.blue_team_name}\" and (http.request.uri matches \".*security-monitor.*\" or dns.domains in {\"splunk.com\", \"elastic.co\", \"sentinelone.com\"})"
}

# Default allow rule for authenticated users
resource "cloudflare_zero_trust_gateway_policy" "default_authenticated_allow" {
  account_id  = var.account_id
  name        = "Default Allow for Authenticated Users"
  description = "Allow all other traffic for authenticated users"
  precedence  = 100  # Low priority, evaluated last
  action      = "allow"
  filters     = ["http", "dns"]
  traffic     = "cf.identity.email != \"\""  # Any authenticated user with an email
}

# Improved WARP enrollment application
resource "cloudflare_zero_trust_access_application" "warp_enrollment_app" {
  account_id             = var.account_id
  session_duration       = "24h"  # Increased from 18h for better user experience
  name                   = "${var.warp_name} - Device Enrollment"
  allowed_idps           = [var.azure_ad_provider_id]
  auto_redirect_to_identity = true
  type                   = "warp"
  app_launcher_visible   = false
  
  lifecycle {
    create_before_destroy = true
  }
}

# Team-specific WARP enrollment policies
resource "cloudflare_zero_trust_access_policy" "red_team_warp_policy" {
  application_id = cloudflare_zero_trust_access_application.warp_enrollment_app.id
  account_id     = var.account_id
  name           = "Red Team WARP Access"
  decision       = "allow"
  precedence     = 1
  
  include {
    azure {
      id = var.red_team_group_ids
      identity_provider_id = var.azure_ad_provider_id
    }
  }
}

resource "cloudflare_zero_trust_access_policy" "blue_team_warp_policy" {
  application_id = cloudflare_zero_trust_access_application.warp_enrollment_app.id
  account_id     = var.account_id
  name           = "Blue Team WARP Access"
  decision       = "allow"
  precedence     = 2
  
  include {
    azure {
      id = var.blue_team_group_ids
      identity_provider_id = var.azure_ad_provider_id
    }
  }
}