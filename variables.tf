variable create_group {
  type = bool
  default = false
}

variable group_name {
  type = string
}

variable group_description {
  type = string
  default = "Gitlab group created by Terraform"
}

variable project_name {
  type = string
}

variable project_description {
  type = string
  default = "Gitlab project created by Terraform"
}

variable project_visibility_level {
  type = string
  default = "private"
}

variable jwt_path {
	type = string
	default = "jwt"
}

variable token_policies {
	type = list
	default = ["static_creds"]
}

variable slack_webhook {
	type = string
	default = ""
}