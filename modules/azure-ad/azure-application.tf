# resource "azuread_application" "aws_sso" {
#   display_name     = var.prefix
#   identifier_uris  = [var.aws_saml_entity_id]
#   owners           = [data.azuread_client_config.current.object_id]
#   logo_image       = filebase64("logo.png") # REPLACE with your logo file
#   sign_in_audience = "AzureADMyOrg"

#   web {
#     redirect_uris = [
#       va.aws_saml_acs
#     ]
#   }
#   # TODO see how can we use these app_role in AWS Identity Center.
#   app_role {
#     id                   = uuidv5("url", "urn:administrator")
#     value                = local.administrator_app_role
#     description          = "Administrator"
#     display_name         = "Administrator"
#     allowed_member_types = ["User"]
#   }
#   app_role {
#     id                   = uuidv5("url", "urn:reader")
#     value                = local.reader_app_role
#     description          = "Reader"
#     display_name         = "Reader"
#     allowed_member_types = ["User"]
#   }
# }

# resource "azuread_service_principal" "aws_sso" {
#   client_id                     = azuread_application.aws_sso.client_id
#   app_role_assignment_required  = true
#   owners                        = [data.azuread_client_config.current.object_id]
#   preferred_single_sign_on_mode = "saml"
# }

# resource "time_rotating" "rotation_years" {
#   rotation_years = 3
# }


# resource "azuread_service_principal_token_signing_certificate" "aws_sso" {
#   service_principal_id = azuread_service_principal.aws_sso.id
#   end_date             = time_rotating.rotation_years.rotation_rfc3339
#   display_name         = "CN=${azuread_application.aws_sso.display_name} SSO Certificate" # (default: Microsoft Azure Federated SSO Certificate)
#   # TODO find a non provisioner way of doing this.
#   provisioner "local-exec" {
#     # NB this is in a single line to make it work in a linux or windows host.
#     command = "az ad sp update --id ${self.service_principal_id} --set preferredTokenSigningKeyThumbprint=${self.thumbprint}"
#   }
# }

# resource "saml_metadata" "aws_sso" {
#   url                          = local.saml_metadata_url
#   token_signing_key_thumbprint = azuread_service_principal_token_signing_certificate.aws_sso.thumbprint
# }
