data "gitlab_group" "this" {
  count     = var.create_group == false ? 1 : 0
  full_path = var.group_name
}

resource "gitlab_group" "this" {
  count       = var.create_group == true ? 1 : 0
  name        = var.group_name
  path        = var.group_name
  description = var.group_description
}

resource "gitlab_project" "this" {
  name        = var.project_name
  description = var.project_description

  visibility_level = var.project_visibility_level
  namespace_id     = var.create_group == false ? data.gitlab_group.this[0].id : gitlab_group.this[0].id

  initialize_with_readme = true
  issues_enabled         = true
}

