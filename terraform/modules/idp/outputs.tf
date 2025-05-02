# terraform/modules/idp/outputs.tf
output "entra_idp_id" {
  value = cloudflare_zero_trust_access_identity_provider.microsoft_entra_id.id
  description = "The ID of the Microsoft Entra ID identity provider"
}

output "red_team_id" {
  value = cloudflare_zero_trust_access_group.red_team.id
  description = "The ID of the red team access group"
}

output "blue_team_id" {
  value = cloudflare_zero_trust_access_group.blue_team.id
  description = "The ID of the blue team access group"
}