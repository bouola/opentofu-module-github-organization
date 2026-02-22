locals {
  extra_tags = ["bouola"]
  repositories = {
    for repository in var.github_organization_repositories :
    replace(repository.name, " ", "-") => repository
  }

  collaborators_mapping_with_project_and_username = flatten([
    for repository in var.github_organization_repositories : [
      for collaborator in repository.collaborators : {
        project    = repository.name
        username   = collaborator.username
        permission = collaborator.permission
      }
    ]
  ])
}

locals {
  collaborators = {
    for collaborator in local.collaborators_mapping_with_project_and_username :
    "${collaborator["username"]}-${collaborator["project"]}" => collaborator
  }
}

resource "github_repository" "repositories" {
  for_each    = local.repositories
  name        = each.key
  description = each.value.description
  visibility  = each.value.visibility

  has_discussions      = each.value.has_discussions
  has_downloads        = lookup(each.value, "has_downloads", null)
  has_projects         = each.value.has_projects
  has_wiki             = each.value.has_wiki
  has_issues           = each.value.has_issues
  auto_init            = true
  gitignore_template   = each.value.git_ignore_template
  archived             = each.value.archived
  vulnerability_alerts = each.value.archived ? each.value.vulnerability_alerts : false

  topics = concat(each.value.tags, local.extra_tags)
  dynamic "pages" {
    for_each = each.value.enable_pages ? { branch = each.value.default_branch_name } : {}
    content {
      source {
        branch = pages.value
        path   = "/docs"
      }
    }
  }

  lifecycle {
    ignore_changes = [
      has_wiki
    ]
  }
}

resource "github_branch_default" "default" {
  for_each   = local.repositories
  branch     = each.value.default_branch_name
  repository = github_repository.repositories[each.key].name
}

resource "github_repository_collaborators" "collaborators" {
  for_each   = local.collaborators
  repository = each.value.project

  user {
    permission = each.value.permission
    username   = each.value.username
  }
}
