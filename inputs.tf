# 🔐 GitHub Authentication
variable "github_organization_owner" {
  description = "The GitHub organization owner or admin username."
  type        = string
  sensitive   = true
  default     = "bouola"
}

# 👥 GitHub Organization Users
variable "github_organization_users" {
  description = "List of organization admins. Use 'disabled' to temporarily exclude a user. Role value can be admin or member"
  type = list(object({
    username = string,
    disabled = optional(bool, false)
    role     = optional(string, "member")
  }))
  default = []
}

# 📁 GitHub Repositories Configuration
variable "github_organization_repositories" {
  description = "List of GitHub repositories to create or manage, including settings and collaborators."
  type = list(object({
    name                 = string                     # Repository name
    description          = string                     # Repository description
    tags                 = list(string)               # Tags used for filtering/grouping
    visibility           = optional(string, "public") # 'public', 'private', or 'internal'
    enable_pages         = optional(bool, false)      # Enable GitHub Pages
    has_discussions      = optional(bool, false)      # Enable Discussions
    has_issues           = optional(bool, false)      # Enable Issues
    has_projects         = optional(bool, false)      # Enable Projects
    has_wiki             = optional(bool, true)       # Enable Wiki
    archived             = optional(bool, false)      # Archive the repository
    git_ignore_template  = optional(string, "Python") # Git ignore template
    default_branch_name  = optional(string, "main")   # Git default branch name
    vulnerability_alerts = optional(bool, true)       # Enable Dependabot alerts
    collaborators = optional(list(object({            # List of collaborators with permissions
      username   = string                             # Collaborator GitHub username
      permission = optional(string, "push")           # 'pull', 'push', 'admin', 'maintain', 'triage'
    })), [])
  }))
  default = []
}
