output "auth_role_name" {
  description = "JWT login role name used by the workload for login."
  value       = vault_jwt_auth_backend_role.this.role_name
}

output "cluster_name" {
  description = "Echo of cluster_name input."
  value       = var.cluster_name
}

output "entity_id" {
  description = "Vault identity entity ID to be passed to use-case modules."
  value       = vault_identity_entity.this.id
}

output "principal_name" {
  description = "Echo of principal_name input."
  value       = var.principal_name
}
