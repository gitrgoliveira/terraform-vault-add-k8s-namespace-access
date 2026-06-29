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

## No-code provisioning

This module is no-code enabled in the `hc-ric-demo` private registry (pinned to `0.0.2`). Open the module, click **Provision workspace**, choose a project and workspace name, then complete the form. Trust outputs from `cluster-onboarding` feed `jwt_auth_path` and `jwt_mount_accessor`.

Form fields:

| Field | Required | Notes |
|---|---|---|
| `cluster_name` | yes | Cluster identifier |
| `principal_name` | yes | Principal identifier |
| `jwt_auth_path` | yes | From trust module |
| `jwt_mount_accessor` | yes | From trust module |
| `ocp_namespace` | yes | ServiceAccount namespace |
| `service_account_name` | yes | ServiceAccount name |
| `bound_audiences` | no | Default `["vault"]` |

## Registry usage

```hcl
module "add_k8s_namespace" {
  source  = "app.terraform.io/<org>/add-k8s-namespace-access/vault"
  version = "~> 0.0.2"

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
