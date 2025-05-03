## Testing the Zero Trust Implementation

### WARP Client Setup

1. Download and install the Cloudflare WARP client on your device
   - Windows: https://1.1.1.1/Cloudflare_WARP_Release-x64.msi
   - MacOS: https://1.1.1.1/Cloudflare_WARP.pkg
   - Linux: https://pkg.cloudflareclient.com/

2. After installation, click on "Settings" in the WARP client
3. Choose "Account" > "Login with Cloudflare for Teams"
4. Enter your team name (the domain name from the Terraform output)
5. You will be redirected to your identity provider login page
6. Enter your Azure AD credentials for the Red Team or Blue Team account

### Testing Red Team Access

1. Once authenticated, try to access:
   - Shared application: `https://app-[workspace].gvolt.co.uk`
   - Red Team application: `https://red-app-[workspace].gvolt.co.uk`
   - Blue Team application: `https://blue-app-[workspace].gvolt.co.uk` (should be denied)

2. Try to access security tools:
   - `https://kali.org`
   - `https://metasploit.com`
   - These should be allowed for Red Team members.

### Testing Blue Team Access

1. Once authenticated, try to access:
   - Shared application: `https://app-[workspace].gvolt.co.uk`
   - Blue Team application: `https://blue-app-[workspace].gvolt.co.uk`
   - Red Team application: `https://red-app-[workspace].gvolt.co.uk` (should be denied)

2. Try to access monitoring tools:
   - `https://splunk.com`
   - `https://elastic.co`
   - These should be allowed for Blue Team members.

### Device Posture Testing