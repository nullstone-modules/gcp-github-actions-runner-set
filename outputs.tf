output "project_id" {
  value       = local.project_id
  description = "string ||| The GCP Project ID where this application is hosted."
}

output "image_repo_url" {
  value       = local.repository_url
  description = "string ||| Image registry URL of the docker images used by this runner set."
}

output "image_pusher" {
  value = {
    email       = try(google_service_account.image_pusher.email, "")
    impersonate = true
  }

  description = "object({ email: string, impersonate: bool }) ||| A GCP service account that is allowed to push images."

  sensitive = true
}

output "runs_on" {
  value       = var.runs_on
  description = "string ||| Use this value to execute a GitHub Actions workflow using these self-hosted runners. `runs-on: <runs_on>`"
}

output "service_namespace" {
  value       = local.runners_namespace
  description = "string ||| This is the Kubernetes namespace containing the runner set."
}

output "service_name" {
  value       = ""
  description = "string ||| This is left empty because there is no long-running service."
}
