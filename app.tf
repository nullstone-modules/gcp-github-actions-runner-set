data "ns_app_env" "this" {
  stack_id = data.ns_workspace.this.stack_id
  app_id   = data.ns_workspace.this.block_id
  env_id   = data.ns_workspace.this.env_id
}

locals {
  app_namespace = local.runners_namespace
  app_name      = local.block_name
  app_version   = coalesce(data.ns_app_env.this.version, "latest")

  app_labels = {
    // k8s-recommended labels
    "app.kubernetes.io/name"       = local.app_name
    "app.kubernetes.io/part-of"    = local.stack_name
    "app.kubernetes.io/managed-by" = "nullstone"
    // nullstone labels
    "nullstone.io/stack" = local.stack_name
    "nullstone.io/block" = local.block_name
    "nullstone.io/env"   = local.env_name
  }
}
