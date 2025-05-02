terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}

# Improved Intune integration
resource "cloudflare_zero_trust_device_posture_integration" "intune_integration" {
  account_id = var.account_id
  name       = "Microsoft Intune Integration"
  type       = "intune"
  interval   = "15m"  # Increased interval to reduce API pressure
  
  config {
    client_id     = var.intune_client_id
    client_secret = var.intune_client_secret
    customer_id   = var.azure_tenant_id
  }
  
  # Add lifecycle to prevent destroy/recreate cycles
  lifecycle {
    create_before_destroy = true
  }
}

# OS Version Check with updated configuration
resource "cloudflare_zero_trust_device_posture_rule" "os_version_windows" {
  account_id  = var.account_id
  name        = "Windows OS Version Check"
  description = "Ensure Windows devices are running supported OS version"
  type        = "os_version"
  
  match {
    platform = "windows"
  }
  
  input {
    version = "10.0"
    operator = ">="
  }
  
  # Ensure we create the integration first
  depends_on = [cloudflare_zero_trust_device_posture_integration.intune_integration]
}

# Disk Encryption Check with fixed configuration
resource "cloudflare_zero_trust_device_posture_rule" "disk_encryption" {
  account_id  = var.account_id
  name        = "Disk Encryption Check"
  description = "Ensure device disk is encrypted"
  type        = "disk_encryption"
  
  match {
    platform = "windows"
  }
  
  # Ensure we create the integration first
  depends_on = [cloudflare_zero_trust_device_posture_integration.intune_integration]
}