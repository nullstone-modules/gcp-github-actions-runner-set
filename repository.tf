resource "google_artifact_registry_repository" "this" {
  location      = local.region
  repository_id = local.resource_name
  format        = "DOCKER"

  docker_config {
    immutable_tags = true
  }

  labels = {
    "nullstone-stack" = local.stack_name
    "nullstone-block" = local.block_name
    "nullstone-env"   = local.env_name
  }
}

locals {
  repository_url = "${google_artifact_registry_repository.this.location}-docker.pkg.dev/${google_artifact_registry_repository.this.project}/${google_artifact_registry_repository.this.name}/${local.app_name}"
}
