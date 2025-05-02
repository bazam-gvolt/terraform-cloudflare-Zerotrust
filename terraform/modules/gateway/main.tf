terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}

# Comment out the DNS location
# resource "cloudflare_zero_trust_dns_location" "gateway" {
#   account_id = var.account_id
#   name       = var.location_name
#   
#   endpoints {
#     ipv4 {
#       enabled = true
#     }
#     ipv6 {
#       enabled = false
#     }
#     doh {
#       enabled = false
#     }
#     dot {
#       enabled = false
#     }
#   }
#   
#   networks {
#     network = "100.64.0.0/24"
#   }
# }

# Comment out the gateway policy
# resource "cloudflare_zero_trust_gateway_policy" "gateway_policy" {
#   account_id  = var.account_id
#   name        = "Default Gateway Policy"
#   description = "Gateway default policy"
#   precedence  = 1
#   action      = "allow"
#   filters     = ["dns"]
#   traffic     = "dns.type in {'A' 'AAAA'}"
# }