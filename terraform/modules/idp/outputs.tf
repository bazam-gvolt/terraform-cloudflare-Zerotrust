# terraform/modules/idp/outputs.tf
output "entra_idp_id" {
  value = cloudflare_zero_trust_access_identity_provider.microsoft_entra_id.id
  description = "The ID of the Microsoft Entra ID identity provider"
}
output "security_teams_id" {
  value = cloudflare_zero_trust_access_group.security_teams.id
}