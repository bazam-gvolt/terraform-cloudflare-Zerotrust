# Student Guide: Deploying Cloudflare Zero Trust with Terraform Cloud

This guide will help you deploy and manage Cloudflare Zero Trust configurations using Terraform Cloud.

## Prerequisites

Before you begin:
1. Create a Terraform Cloud account if you don't have one
2. Join the organization provided by your instructor
3. Prepare your Cloudflare and Azure credentials

## Deployment Steps

### 1. Create Your Workspace

1. In Terraform Cloud, create a new workspace:
   - Select "Version control workflow"
   - Connect to the provided GitHub repository
   - Name your workspace with your student ID (e.g., `student01-zerotrust`)
   - Set working directory to `terraform/environments/prod`

### 2. Configure Variables

Add the following variables to your Terraform Cloud workspace:

| Variable | Description | Sensitive? | Format |
|----------|-------------|-----------|--------|
| `account_id` | Cloudflare Account ID | No | String |
| `api_token` | Cloudflare API Token | Yes | String |
| `azure_client_id` | Azure AD Client ID | No | String |
| `azure_client_secret` | Azure AD Client Secret | Yes | String |
| `azure_directory_id` | Azure AD Tenant ID | No | String |
| `intune_client_id` | Microsoft Intune Client ID | No | String |
| `intune_client_secret` | Microsoft Intune Client Secret | Yes | String |
| `red_team_name` | Name for the red team access group | No | String |
| `red_team_group_ids` | List of Azure AD group IDs for red team | No | HCL list: ["id-value-here"] |
| `blue_team_name` | Name for the blue team access group | No | String |
| `blue_team_group_ids` | List of Azure AD group IDs for blue team | No | HCL list: ["id-value-here"] |

**Important**: When entering Azure AD group IDs, they must be formatted as HCL lists with square brackets, e.g., `["00000000-0000-0000-0000-000000000000"]` even if there's only one ID.

### 3. Run the Deployment

1. Go to the "Runs" tab in your workspace
2. Click "Queue plan manually"
3. Review the plan output carefully
4. If everything looks good, click "Confirm & Apply"

### 4. Troubleshooting

If you encounter errors during the deployment:

#### Domain Validation Error (12130)
This is expected for lab environments. The code includes `skip_domain_verification = true` to bypass this check.

#### Application Already Exists Error (11010)
The WARP enrollment application name is set to include your workspace name for uniqueness. If you still encounter this issue, you may need to delete the application manually in the Cloudflare dashboard.

#### HTTP 500 Error with Intune Integration
Check your Intune credentials and make sure the application has the necessary permissions. The code includes retry logic to handle temporary issues.

### 5. Cleanup

When you've completed the lab:
1. Go to the "Settings" tab in your workspace
2. Scroll down to "Destruction and Deletion"
3. Click "Queue destroy plan"
4. Confirm to remove all created resources

## Support

If you need assistance:
1. Check the error messages in the Terraform Cloud run output
2. Review the troubleshooting section in this guide
3. Contact your instructor with specific error details