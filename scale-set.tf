// Installs the runner scale set
// See https://docs.github.com/en/actions/tutorials/use-actions-runner-controller/quickstart#configuring-a-runner-scale-set
resource "helm_release" "scale_set" {
  name       = local.resource_name
  namespace  = local.runners_namespace
  repository = "oci://ghcr.io/actions/actions-runner-controller-charts"
  chart      = "gha-runner-scale-set"

  values = [
    yamlencode({
      githubConfigUrl    = local.github_config_url
      githubConfigSecret = local.github_config_secret
      runnerScaleSetName = var.runs_on

      image = {
        repository = local.repository_url
        pullPolicy = "IfNotPresent"
        tag        = local.app_version
      }
    })
  ]
}
