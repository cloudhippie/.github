resource "github_membership" "general" {
  for_each = { for row in var.members : row.name => row }

  username = each.value.name
  role     = each.value.role
}
