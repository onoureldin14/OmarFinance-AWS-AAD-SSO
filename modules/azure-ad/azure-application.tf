resource "azuread_application" "aws_sso" {
  display_name     = var.prefix
  identifier_uris  = [var.aws_saml_entity_id]
  owners           = [data.azuread_client_config.current.object_id]
  logo_image       = filebase64("logo.png") # REPLACE with your logo file
  sign_in_audience = "AzureADMyOrg"

  web {
    redirect_uris = [
      va.aws_saml_acs,
    ]
  }
  # TODO see how can we use these app_role in AWS Identity Center.
  app_role {
    id                   = uuidv5("url", "urn:administrator")
    value                = local.administrator_app_role
    description          = "Administrator"
    display_name         = "Administrator"
    allowed_member_types = ["User"]
  }
  app_role {
    id                   = uuidv5("url", "urn:reader")
    value                = local.reader_app_role
    description          = "Reader"
    display_name         = "Reader"
    allowed_member_types = ["User"]
  }
}

resource "azuread_service_principal" "aws_sso" {
  client_id                         = azuread_application.aws_sso.client_id
  app_role_assignment_required       = true
  owners                             = [data.azuread_client_config.current.object_id]
  preferred_single_sign_on_mode     = "saml"
}