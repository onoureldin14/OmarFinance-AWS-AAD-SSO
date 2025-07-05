module "aws_identity_with_sso" {
  source = "./modules/aws-iam"

  identity_store_id = data.aws_ssoadmin_instances.management_account.identity_store_ids[0]
  sso_instance_arn  = data.aws_ssoadmin_instances.management_account.arns[0]
  aws_account_id    = data.aws_caller_identity.current.account_id

  users = local.identity_users

  roles = local.identity_users_roles

  role_policies = local.identity_users_role_policies
}


module "azuread_sso_app" {
  source            = "./modules/azure-ad"
  prefix            = var.aws_app_prefix
  saml_entity_id    = var.aws_saml_entity_id
  saml_acs          = var.aws_saml_acs
  login_url         = var.aws_sso_loging_url
  azure_app_roles   = local.identity_users_roles
  users             = local.identity_users
  logo_image_base64 = filebase64("${path.module}/assets/logo.png")

  depends_on = [module.aws_identity_with_sso]
}


module "teleport_azuread_app" {
  count             = var.enable_teleport ? 1 : 0
  source            = "./modules/azure-ad"
  prefix            = var.teleport_app_prefix
  application_type  = "teleport"
  saml_entity_id    = var.teleport_saml
  saml_acs          = var.teleport_saml
  azure_app_roles   = local.identity_users_roles
  users             = local.identity_users
  logo_image_base64 = filebase64("${path.module}/assets/teleport.png")

  depends_on = [module.aws_identity_with_sso]
}
