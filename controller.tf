data "ns_connection" "controller" {
  name     = "controller"
  contract = "block/gcp/github-actions:k8s"
}

locals {
  github_config_secret = data.ns_connection.controller.outputs.github_config_secret
  runners_namespace    = data.ns_connection.controller.outputs.default_runners_namespace
}
