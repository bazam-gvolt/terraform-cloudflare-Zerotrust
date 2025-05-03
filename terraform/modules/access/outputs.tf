output "app_id" {
  value = cloudflare_zero_trust_access_application.app.id
  description = "The ID of the shared application"
}

output "red_team_app_id" {
  value = cloudflare_zero_trust_access_application.red_team_app.id
  description = "The ID of the Red Team application"
}

output "blue_team_app_id" {
  value = cloudflare_zero_trust_access_application.blue_team_app.id
  description = "The ID of the Blue Team application"
}

output "shared_app_domain" {
  value = cloudflare_zero_trust_access_application.app.domain
  description = "Domain for the shared application"
}

output "red_team_app_domain" {
  value = cloudflare_zero_trust_access_application.red_team_app.domain
  description = "Domain for the Red Team application"
}

output "blue_team_app_domain" {
  value = cloudflare_zero_trust_access_application.blue_team_app.domain
  description = "Domain for the Blue Team application"
}