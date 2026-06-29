# terraform-vault-add-k8s-namespace-access

Principal-layer module that onboards one Kubernetes or OpenShift ServiceAccount as a Vault identity entity, alias, and JWT login role.

## Layer

Principal. This module creates identity and login, but no secret policy grants.

## Prerequisites

- Trust module already provisioned (`jwt_auth_path`, `jwt_mount_accessor`)
- ServiceAccount namespace and name known

## Inputs

| Name | Type | Description |
|---|---|---|
| `cluster_name` | `string` | Cluster identifier, regex validated |
| `principal_name` | `string` | Principal identifier, regex validated |
| `jwt_auth_path` | `string` | Trust mount path |
| `jwt_mount_accessor` | `string` | Trust mount accessor |
| `ocp_namespace` | `string` | ServiceAccount namespace |
| `service_account_name` | `string` | ServiceAccount name |
| `bound_audiences` | `list(string)` | JWT role bound audiences, default `["vault"]` |
| `token_ttl` | `number` | JWT role TTL in seconds, default `3600` |
| `token_max_ttl` | `number` | JWT role max TTL in seconds, default `86400` |

## Outputs

| Name | Description |
|---|---|
| `entity_id` | Entity ID for downstream use-case modules |
| `auth_role_name` | JWT role name used by workload login |
| `cluster_name` | Echo |
| `principal_name` | Echo |

## No-code notes

- `token_policies` on the principal login role is intentionally empty.
- Policy grants are attached later through use-case identity groups.

## Registry usage

```hcl
module "add_k8s_namespace" {
  source  = "app.terraform.io/<org>/add-k8s-namespace-access/vault"
  version = "~> 0.1"

  cluster_name         = "ocp-prod-eu"
  principal_name       = "payments"
  jwt_auth_path        = "jwt/ocp-prod-eu"
  jwt_mount_accessor   = "auth_jwt_12345678"
  ocp_namespace        = "payments-ns"
  service_account_name = "payments-sa"
  bound_audiences      = ["vault"]
}
```

Next step in chain: use-case modules consume `entity_id`.
