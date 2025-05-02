
[terraform/modules/device_posture/README.md](terraform/modules/device_posture/README.md):
```markdown
# Cloudflare Device Posture Module

This module configures device posture checks including:
- OS Version Check
- Device Posture Rules

## Usage

```hcl
module "device_posture" {
  source = "../../modules/device_posture"

  account_id = var.account_id
}