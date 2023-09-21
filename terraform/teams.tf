locals {
  team_repositories = flatten([
    for repository in data.github_repositories.available.names : [
      for index, team in var.teams : [
        {
          name       = "${team.name}-${repository}"
          team       = team.name
          repository = repository
          permission = team.permission
        }
      ]
    ]
  ])
}

resource "github_team" "general" {
  for_each = { for row in var.teams : row.name => row }

  name    = each.value.name
  privacy = each.value.privacy
}

resource "github_team_members" "general" {
  for_each = { for row in var.teams : row.name => row }
  team_id  = github_team.general[each.value.name].id

  dynamic "members" {
    for_each = each.value.members

    content {
      username = members.value.name
      role     = members.value.role
    }
  }
}

resource "github_team_repository" "general" {
  for_each = { for row in local.team_repositories : row.name => row }

  team_id    = github_team.general[each.value.team].id
  repository = each.value.repository
  permission = each.value.permission
}
