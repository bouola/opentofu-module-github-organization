<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9 |
| <a name="requirement_github"></a> [github](#requirement\_github) | ~> 6.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_github"></a> [github](#provider\_github) | ~> 6.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [github_branch_default.default](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch_default) | resource |
| [github_membership.users](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/membership) | resource |
| [github_repository.repositories](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository) | resource |
| [github_repository_collaborators.collaborators](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_collaborators) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_github_organization_owner"></a> [github\_organization\_owner](#input\_github\_organization\_owner) | The GitHub organization owner or admin username. | `string` | `"bouola"` | no |
| <a name="input_github_organization_repositories"></a> [github\_organization\_repositories](#input\_github\_organization\_repositories) | List of GitHub repositories to create or manage, including settings and collaborators. | <pre>list(object({<br/>    name                 = string                     # Repository name<br/>    description          = string                     # Repository description<br/>    tags                 = list(string)               # Tags used for filtering/grouping<br/>    visibility           = optional(string, "public") # 'public', 'private', or 'internal'<br/>    enable_pages         = optional(bool, false)      # Enable GitHub Pages<br/>    has_discussions      = optional(bool, false)      # Enable Discussions<br/>    has_issues           = optional(bool, false)      # Enable Issues<br/>    has_projects         = optional(bool, false)      # Enable Projects<br/>    has_wiki             = optional(bool, true)       # Enable Wiki<br/>    archived             = optional(bool, false)      # Archive the repository<br/>    git_ignore_template  = optional(string, "Python") # Git ignore template<br/>    default_branch_name  = optional(string, "main")   # Git default branch name<br/>    vulnerability_alerts = optional(bool, true)       # Enable Dependabot alerts<br/>    collaborators = optional(list(object({            # List of collaborators with permissions<br/>      username   = string                             # Collaborator GitHub username<br/>      permission = optional(string, "push")           # 'pull', 'push', 'admin', 'maintain', 'triage'<br/>    })), [])<br/>  }))</pre> | `[]` | no |
| <a name="input_github_organization_users"></a> [github\_organization\_users](#input\_github\_organization\_users) | List of organization admins. Use 'disabled' to temporarily exclude a user. Role value can be admin or member | <pre>list(object({<br/>    username = string,<br/>    disabled = optional(bool, false)<br/>    role     = optional(string, "member")<br/>  }))</pre> | `[]` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
