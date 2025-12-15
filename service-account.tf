resource "google_service_account" "app" {
  account_id   = local.resource_name
  display_name = "Service Account for Runner Set ${local.app_name}"
}

resource "kubernetes_service_account_v1" "app" {
  metadata {
    namespace = local.app_namespace
    name      = local.app_name
    labels    = local.app_labels

    annotations = {
      // This indicates which GCP service account this kubernetes service account can impersonate
      "iam.gke.io/gcp-service-account" = google_service_account.app.email
    }
  }

  automount_service_account_token = true
}

// This allows the kubernetes service account <app-namespace>/<app-name> to impersonate a workload identity
resource "google_service_account_iam_member" "app_workload_identity" {
  service_account_id = google_service_account.app.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "serviceAccount:${local.project_id}.svc.id.goog[${local.app_namespace}/${local.app_name}]"
}

resource "google_service_account_iam_member" "app_generate_token" {
  service_account_id = google_service_account.app.name
  role               = "roles/iam.serviceAccountTokenCreator"
  member             = "serviceAccount:${local.project_id}.svc.id.goog[${local.app_namespace}/${local.app_name}]"
}

resource "kubernetes_role_v1" "github_config" {
  metadata {
    namespace = local.app_namespace
    name      = "${local.app_name}-github-config"
    labels    = local.app_labels
  }

  rule {
    api_groups     = [""]
    resources      = ["secrets"]
    verbs          = ["get"]
    resource_names = [local.github_config_secret]
  }
}

resource "kubernetes_role_binding_v1" "app_read_secret" {
  metadata {
    namespace = local.app_namespace
    name      = "${local.app_name}-github-config"
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account_v1.app.metadata[0].name
    namespace = kubernetes_service_account_v1.app.metadata[0].namespace
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = kubernetes_role_v1.github_config.metadata[0].name
  }
}
