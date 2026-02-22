terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }

  required_version = ">= 1.9"
}

provider "github" {
  owner = var.github_organization_owner
}
