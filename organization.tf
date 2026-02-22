# Add a user to the organization
locals {
  github_organization_users = { for user in var.github_organization_users : user.username => user if !user.disabled }
}

resource "github_membership" "users" {
  for_each = local.github_organization_users
  username = each.key
  role     = each.value.role
}
