module "aws_identity_with_sso" {
  source = "./modules/aws-iam"

  identity_store_id = data.aws_ssoadmin_instances.management_account.identity_store_ids[0]
  sso_instance_arn  = data.aws_ssoadmin_instances.management_account.arns[0]
  aws_account_id    = data.aws_caller_identity.current.account_id

  users = local.aws_identity_users

  roles = local.aws_identity_users_roles

  role_policies = local.aws_identity_users_role_policies
}
