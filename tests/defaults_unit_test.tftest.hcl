mock_provider "vault" {}

run "defaults_plan_succeeds" {
  command = plan

  variables {
    bound_audiences      = ["vault"]
    cluster_name         = "dev-cluster"
    jwt_auth_path        = "jwt/dev-cluster"
    jwt_mount_accessor   = "auth_jwt_deadbeef"
    ocp_namespace        = "apps"
    principal_name       = "orders"
    service_account_name = "orders-sa"
  }

  assert {
    condition     = output.cluster_name == "dev-cluster"
    error_message = "cluster_name output should echo input."
  }

  assert {
    condition     = output.principal_name == "orders"
    error_message = "principal_name output should echo input."
  }

  assert {
    condition     = output.auth_role_name == "dev-cluster-orders"
    error_message = "auth_role_name should be derived as <cluster_name>-<principal_name>."
  }
}
