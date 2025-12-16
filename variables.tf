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

variable "enable_docker" {
  type        = bool
  default     = false
  description = <<EOF
When enabled, this allows workflows to use the host docker daemon for `docker`.

The runner docker image must be executed with a user in the linux group `123`.
In your Dockerfile, make sure to add the user to a group with the GID `123`.
EOF
}
