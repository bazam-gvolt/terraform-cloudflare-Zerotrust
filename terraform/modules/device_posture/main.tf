terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"  # Keep at version 4
    }
  }
}

# Improved Intune integration
resource "cloudflare_zero_trust_device_posture_integration" "intune_integration" {
  account_id = var.account_id
  name       = "Microsoft Intune Integration"
  type       = "intune"
  interval   = "15m"
  
  config {
    client_id     = var.intune_client_id
    client_secret = var.intune_client_secret
    customer_id   = var.azure_tenant_id
  }
  
  lifecycle {
    create_before_destroy = true
  }
}

# OS Version Check with corrected version format
resource "cloudflare_zero_trust_device_posture_rule" "os_version_windows" {
  account_id  = var.account_id
  name        = "Windows OS Version Check"
  description = "Ensure Windows devices are running supported OS version"
  type        = "os_version"
  
  match {
    platform = "windows"
  }
  
  input {
    version = "10.0.0"  # Fixed semver format
    operator = ">="
  }
  
  depends_on = [cloudflare_zero_trust_device_posture_integration.intune_integration]
}

# Disk Encryption Check
resource "cloudflare_zero_trust_device_posture_rule" "disk_encryption" {
  account_id  = var.account_id
  name        = "Disk Encryption Check"
  description = "Ensure device disk is encrypted"
  type        = "disk_encryption"
  
  match {
    platform = "windows"
  }
  
  depends_on = [cloudflare_zero_trust_device_posture_integration.intune_integration]
}

# Firewall Check - additional security
resource "cloudflare_zero_trust_device_posture_rule" "firewall_check" {
  account_id  = var.account_id
  name        = "Firewall Status Check"
  description = "Ensure device firewall is enabled"
  type        = "firewall"
  
  match {
    platform = "windows"
  }
  
  depends_on = [cloudflare_zero_trust_device_posture_integration.intune_integration]
}

# Antivirus Check - additional security
resource "cloudflare_zero_trust_device_posture_rule" "antivirus_check" {
  account_id  = var.account_id
  name        = "Antivirus Status Check"
  description = "Ensure device has antivirus enabled"
  type        = "sentinelone"
  
  match {
    platform = "windows"
  }
  
  depends_on = [cloudflare_zero_trust_device_posture_integration.intune_integration]
}

# File existence check for Blue Team - CORRECTED
resource "cloudflare_zero_trust_device_posture_rule" "blue_team_file_check" {
  account_id  = var.account_id
  name        = "Blue Team File Check"
  description = "Check for presence of Blue Team software"
  type        = "file"
  
  match {
    platform = "windows"
  }
  
  input {
    file_path = "%PROGRAMFILES%\BlueTeam\agent.txt"
    exists = true
  }
  
  depends_on = [cloudflare_zero_trust_device_posture_integration.intune_integration]
}

# File existence check for Red Team - CORRECTED
resource "cloudflare_zero_trust_device_posture_rule" "red_team_file_check" {
  account_id  = var.account_id
  name        = "Red Team File Check"
  description = "Check for presence of Red Team software"
  type        = "file"
  
  match {
    platform = "windows"
  }
  
  input {
    file_path = "%PROGRAMFILES%\RedTeam\agent.txt"
    exists = true
  }
  
  depends_on = [cloudflare_zero_trust_device_posture_integration.intune_integration]
}