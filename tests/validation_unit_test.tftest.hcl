mock_provider "vault" {}

run "invalid_principal_name_fails_validation" {
  command = plan

  variables {
    bound_audiences      = ["vault"]
    cluster_name         = "dev-cluster"
    jwt_auth_path        = "jwt/dev-cluster"
    jwt_mount_accessor   = "auth_jwt_deadbeef"
    ocp_namespace        = "apps"
    principal_name       = "INVALID_NAME"
    service_account_name = "orders-sa"
  }

  expect_failures = [
    var.principal_name,
  ]
}

run "invalid_cluster_name_fails_validation" {
  command = plan

  variables {
    bound_audiences      = ["vault"]
    cluster_name         = "-bad"
    jwt_auth_path        = "jwt/dev-cluster"
    jwt_mount_accessor   = "auth_jwt_deadbeef"
    ocp_namespace        = "apps"
    principal_name       = "orders"
    service_account_name = "orders-sa"
  }

  expect_failures = [
    var.cluster_name,
  ]
}
