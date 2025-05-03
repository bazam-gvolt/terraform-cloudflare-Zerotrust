output "disk_encryption_rule_id" {
  value = cloudflare_zero_trust_device_posture_rule.disk_encryption.id
  description = "The ID of the disk encryption posture rule"
}

output "os_version_rule_id" {
  value = cloudflare_zero_trust_device_posture_rule.os_version_windows.id
  description = "The ID of the OS version posture rule"
}

output "firewall_rule_id" {
  value = cloudflare_zero_trust_device_posture_rule.firewall_check.id
  description = "The ID of the firewall posture rule"
}

output "antivirus_rule_id" {
  value = cloudflare_zero_trust_device_posture_rule.antivirus_check.id
  description = "The ID of the antivirus posture rule"
}

output "blue_team_file_rule_id" {
  value = cloudflare_zero_trust_device_posture_rule.blue_team_file_check.id
  description = "The ID of the Blue Team file check rule"
}

output "red_team_file_rule_id" {
  value = cloudflare_zero_trust_device_posture_rule.red_team_file_check.id
  description = "The ID of the Red Team file check rule"
}