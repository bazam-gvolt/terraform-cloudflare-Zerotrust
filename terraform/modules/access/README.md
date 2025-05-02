
[terraform/modules/access/README.md](terraform/modules/access/README.md):
```markdown
# Cloudflare Access Module

This module configures Cloudflare Access applications including:
- Access Application Configuration
- Default Access Policy

## Usage

```hcl
module "access" {
  source = "../../modules/access"

  account_id     = var.account_id
  app_name       = "My App"
  app_domain     = "app.example.com"
  allowed_emails = ["user@example.com"]
}