# locals {
#   saml_metadata_url      = "https://login.microsoftonline.com/${azuread_service_principal.example.application_tenant_id}/federationmetadata/2007-06/federationmetadata.xml?appid=${azuread_service_principal.example.application_id}"
#   saml_metadata_document = saml_metadata.example.document
#   administrator_app_role = "administrator"
#   reader_app_role        = "reader"

#   role_mapping = {
#     administrator = azuread_application.example.app_role_ids[local.administrator_app_role]
#     reader        = azuread_application.example.app_role_ids[local.reader_app_role]
#   }

# }
