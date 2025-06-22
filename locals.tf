locals {
  aws_identity_users = {
    jane = {
      user_principal_name = var.jane_user_email
      display_name        = "Jane Smith"
      given_name          = "Jane"
      surname             = "Smith"
      email               =  var.jane_user_email
      role                = "platform"
    },
    john = {
      user_principal_name = var.john_user_email
      display_name        = "John Doe"
      given_name          = "John"
      surname             = "Doe"
      email               = var.john_user_email
      role                = "product"
    }
  }
  aws_identity_users_roles = {
    platform       = "Platform"
    product        = "Product"
  }
  aws_identity_users_role_policies = {
    platform       = data.aws_iam_policy.AdministratorAccess.arn
    product        = data.aws_iam_policy.ReadOnlyAccess.arn
  }


}