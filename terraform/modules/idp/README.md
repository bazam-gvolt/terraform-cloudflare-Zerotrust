# terraform/modules/idp/README.md
# Cloudflare Identity Provider Module

This module configures Microsoft Entra ID as an identity provider for Cloudflare Access.

## Usage

```hcl
module "idp" {
  source = "../../modules/idp"

  account_id          = var.account_id
  azure_client_id     = var.azure_client_id
  azure_client_secret = var.azure_client_secret
  azure_directory_id  = var.azure_directory_id
}
```

## Notes

This module requires Cloudflare provider version `>=4.40.0`.

Your API token must have the following permission:
* `Access: Organizations, Identity Providers, and Groups Write`

### UPN and email
If your organization's UPNs do not match users' email addresses, you must add a custom claim for email in Entra ID. 
By default, Cloudflare will first look for the unique claim name you created and configured in the Cloudflare dashboard 
to represent email (for example, `email_identifier`) in the `id_token` JSON response. If you did not configure a unique 
claim name, Cloudflare will then look for an `email` claim. Last, if neither claim exists, Cloudflare will look for the UPN claim.