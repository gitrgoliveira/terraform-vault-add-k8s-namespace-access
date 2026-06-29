variable "bound_audiences" {
  type        = list(string)
  description = "Bound audiences for the principal JWT login role."
  default     = ["vault"]
}

variable "cluster_name" {
  type        = string
  description = "Cluster identifier from trust module outputs."

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{0,30}[a-z0-9]$", var.cluster_name))
    error_message = "cluster_name must match ^[a-z][a-z0-9-]{0,30}[a-z0-9]$."
  }
}

variable "jwt_auth_path" {
  type        = string
  description = "JWT auth backend path from trust module output."
}

variable "jwt_mount_accessor" {
  type        = string
  description = "JWT mount accessor from trust module output."
}

variable "ocp_namespace" {
  type        = string
  description = "OpenShift or Kubernetes namespace containing the ServiceAccount."
}

variable "principal_name" {
  type        = string
  description = "Short principal identifier used in entity and role naming."

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{0,30}[a-z0-9]$", var.principal_name))
    error_message = "principal_name must match ^[a-z][a-z0-9-]{0,30}[a-z0-9]$."
  }
}

variable "service_account_name" {
  type        = string
  description = "ServiceAccount name within ocp_namespace."
}

variable "token_max_ttl" {
  type        = number
  description = "JWT login role token max TTL in seconds."
  default     = 86400
}

variable "token_ttl" {
  type        = number
  description = "JWT login role token TTL in seconds."
  default     = 3600
}
