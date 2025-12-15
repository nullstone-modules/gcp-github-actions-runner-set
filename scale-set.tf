// Installs the runner scale set
// See https://docs.github.com/en/actions/tutorials/use-actions-runner-controller/quickstart#configuring-a-runner-scale-set
resource "helm_release" "scale_set" {
  name       = local.resource_name
  namespace  = local.runners_namespace
  repository = "oci://ghcr.io/actions/actions-runner-controller-charts"
  chart      = "gha-runner-scale-set"

  set = [
    {
      name  = "githubConfigUrl"
      value = local.github_config_url
    },
    {
      name  = "githubConfigSecret"
      value = local.github_config_secret
    },
    {
      name  = "runnerScaleSetName"
      value = var.runs_on
    },
    {
      name  = "template"
      value = local.runner_template
    }
  ]
}
