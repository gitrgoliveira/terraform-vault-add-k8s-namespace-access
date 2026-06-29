terraform {
  required_version = ">= 1.9"
}

locals {
  trust_bound_audiences = ["vault"]
  trust_cluster_name    = "ocp-prod-eu"
  trust_jwt_auth_path   = "jwt/ocp-prod-eu"
  trust_mount_accessor  = "auth_jwt_12345678"
}

module "add_k8s_namespace" {
  source = "../../"

  bound_audiences      = local.trust_bound_audiences
  cluster_name         = local.trust_cluster_name
  jwt_auth_path        = local.trust_jwt_auth_path
  jwt_mount_accessor   = local.trust_mount_accessor
  ocp_namespace        = var.ocp_namespace
  principal_name       = var.principal_name
  service_account_name = var.service_account_name
}

variable "ocp_namespace" {
  type        = string
  description = "Namespace of the ServiceAccount."
}

variable "principal_name" {
  type        = string
  description = "Principal identifier used in entity and role naming."
}

variable "service_account_name" {
  type        = string
  description = "ServiceAccount name."
}
