locals {
  repo_labels = {
    // k8s-recommended labels
    "app.kubernetes.io/name"       = local.app_name
    "app.kubernetes.io/part-of"    = local.stack_name
    "app.kubernetes.io/managed-by" = "nullstone"
    // nullstone labels
    "nullstone.io/stack" = local.stack_name
    "nullstone.io/block" = local.block_name
    "nullstone.io/env"   = local.env_name
    "nullstone.io/ref"   = local.block_ref
  }
}

resource "google_artifact_registry_repository" "this" {
  location      = local.region
  repository_id = local.resource_name
  format        = "DOCKER"

  docker_config {
    immutable_tags = true
  }

  labels = local.repo_labels
}

locals {
  repository_url = "${google_artifact_registry_repository.this.location}-docker.pkg.dev/${google_artifact_registry_repository.this.project}/${google_artifact_registry_repository.this.name}/${local.app_name}"
}
