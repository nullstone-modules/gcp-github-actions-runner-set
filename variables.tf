variable "github_org" {
  type        = string
  description = <<EOF
This is the GitHub organization that owns the self-hosted runners.
This will be used to set githubConfigUrl="https://github.com/{var.github_org}".
EOF
}

locals {
  github_config_url = "https://github.com/${var.github_org}"
}

variable "runs_on" {
  type        = string
  description = <<EOF
This is the name of the runner scale set to use in GitHub Actions workflows.
EOF
}
