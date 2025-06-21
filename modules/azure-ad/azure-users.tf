resource "random_password" "password" {
  for_each    = var.users
  length      = 16
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
  min_special = 1
}

resource "azuread_user" "user" {
  for_each             = var.users
  user_principal_name  = each.value.user_principal_name
  display_name         = each.value.display_name
  mail_nickname        = each.value.mail_nickname
  password             = random_password.password[each.key].result
}

resource "azuread_app_role_assignment" "assignment" {
  for_each = var.users
  app_role_id         = local.role_mapping[each.value.role]
  resource_object_id  = azuread_service_principal.aws_sso.object_id
  principal_object_id = azuread_user.user[each.key].object_id
}