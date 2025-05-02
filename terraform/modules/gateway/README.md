# Cloudflare Gateway Module

This module configures Cloudflare Gateway settings including:
- Gateway Location Configuration
- Default Gateway Policy

## Usage

```hcl
module "gateway" {
  source = "../../modules/gateway"

  account_id    = var.account_id
  location_name = "My Gateway"
  networks      = ["192.168.1.0/24"]
}