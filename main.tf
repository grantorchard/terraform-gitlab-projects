locals {
	jwt_path = var.jwt_path
}

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

resource "vault_jwt_auth_backend_role" "this" {
  backend         = local.jwt_path
  role_name       = var.project_name
  token_policies  = var.token_policies
  user_claim      = "user_email"
  role_type       = "jwt"
	bound_claims = {
		"namespace_path" = var.group_name
		"project_id" = gitlab_project.this.id
	}
}