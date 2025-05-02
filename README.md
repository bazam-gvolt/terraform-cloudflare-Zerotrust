# Terraform Cloudflare Zero Trust

This project manages Cloudflare Zero Trust configuration using Terraform. It includes configurations for:
- WARP Configuration
- Device Posture Checks
- Gateway Settings
- Access Applications
- Azure AD Integration

## Project Structure

## Prerequisites
- Terraform Cloud account
- Cloudflare account with Zero Trust enabled
- Azure AD tenant for identity provider

## Usage
1. Configure Terraform Cloud workspace
2. Set required variables in Terraform Cloud
3. Run Terraform apply

## Modules

### Access Module
- **Purpose**: Configures Cloudflare Access applications and policies.
- **Files**:
  - `main.tf`: Defines the access application and policy resources.
  - `outputs.tf`: Outputs the application ID.
  - `variables.tf`: Defines input variables for the module.
  - `README.md`: Documentation for the module.

### Device Posture Module
- **Purpose**: Configures device posture checks including OS version and disk encryption.
- **Files**:
  - `main.tf`: Defines the device posture rules and Intune integration.
  - `outputs.tf`: Outputs the device posture rule IDs.
  - `variables.tf`: Defines input variables for the module.
  - `README.md`: Documentation for the module.

### Gateway Module
- **Purpose**: Configures Cloudflare Gateway settings including DNS locations and policies.
- **Files**:
  - `main.tf`: Defines the DNS location and gateway policy resources.
  - `outputs.tf`: Outputs the location and policy IDs.
  - `variables.tf`: Defines input variables for the module.
  - `README.md`: Documentation for the module.

### IDP Module
- **Purpose**: Configures Azure AD as an identity provider for Cloudflare Access.
- **Files**:
  - `main.tf`: Defines the Azure AD identity provider resource.
  - `outputs.tf`: Outputs the identity provider ID.
  - `variables.tf`: Defines input variables for the module.
  - `README.md`: Documentation for the module.

### WARP Module
- **Purpose**: Configures Cloudflare WARP settings including allow and block policies.
- **Files**:
  - `main.tf`: Defines the WARP policies.
  - `outputs.tf`: Outputs the policy IDs.
  - `variables.tf`: Defines input variables for the module.
  - `README.md`: Documentation for the module.

## Environments

### Development Environment
- **Files**:
  - `main.tf`: Main configuration for the development environment.
  - `outputs.tf`: Outputs for the development environment.
  - `variables.tf`: Input variables for the development environment.

### Production Environment
- **Files**:
  - `main.tf`: Main configuration for the production environment.
  - `outputs.tf`: Outputs for the production environment.
  - `variables.tf`: Input variables for the production environment.

## Prerequisites
- Terraform Cloud account
- Cloudflare account with Zero Trust enabled
- Azure AD tenant for identity provider

## Usage

### Step 1: Configure Terraform Cloud Workspace
1. Go to Terraform Cloud (app.terraform.io)
2. Create a new workspace under your organization (`reddome_academy`)
3. Set the workspace name to `terraform-cloudflare-Zerotrust`
4. Set the working directory to `terraform/environments/prod`

### Step 2: Set Required Variables in Terraform Cloud
Add the following environment variables in your Terraform Cloud workspace:
```hcl
TF_VAR_account_id          = "your-cloudflare-account-id"
TF_VAR_api_token           = "your-cloudflare-api-token"           # Mark as sensitive
TF_VAR_azure_client_id     = "your-azure-client-id"
TF_VAR_azure_client_secret = "your-azure-client-secret"           # Mark as sensitive
TF_VAR_azure_directory_id  = "your-azure-directory-id"
```

# Cloudflare Identity Provider Module

This module configures Azure AD as an identity provider for Cloudflare Access.

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
````
