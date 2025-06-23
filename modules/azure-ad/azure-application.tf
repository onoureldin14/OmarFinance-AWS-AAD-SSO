resource "azuread_application" "aws_sso" {
  display_name     = var.prefix
  identifier_uris  = [var.aws_saml_entity_id]
  owners           = [data.azuread_client_config.current.object_id]
  logo_image       = var.logo_image_base64
  sign_in_audience = "AzureADMyOrg"
  feature_tags {
    custom_single_sign_on = true
    enterprise            = true

  }

  web {
    redirect_uris = [var.aws_saml_acs]
  }

  dynamic "app_role" {
    for_each = var.azure_app_roles

    content {
      id                   = uuidv5("url", "urn:${app_role.key}")
      value                = app_role.key
      description          = app_role.value
      display_name         = app_role.value
      allowed_member_types = ["User"]
    }
  }
}

resource "azuread_service_principal" "aws_sso_sp" {
  client_id                    = azuread_application.aws_sso.client_id
  app_role_assignment_required = true
  owners                       = [data.azuread_client_config.current.object_id]
  login_url                    = "https://d-9367a4182f.awsapps.com/start"
  feature_tags {
    custom_single_sign_on = true
    enterprise            = true
  }
  preferred_single_sign_on_mode = "saml"
}

#################################################
# SAML Metadata Generation for SSO Application
#################################################

resource "time_rotating" "saml-certificate" {
  rotation_years = 3
}

resource "azuread_service_principal_token_signing_certificate" "saml-certificate" {
  service_principal_id = azuread_service_principal.aws_sso_sp.id
  display_name         = "CN=${var.prefix} SSO Certificate"
  end_date             = time_rotating.saml-certificate.rotation_rfc3339

  provisioner "local-exec" {
    # NB this is in a single line to make it work in a linux or windows host.
    command = "az ad sp update --id ${azuread_service_principal.aws_sso_sp.object_id} --set preferredTokenSigningKeyThumbprint=${self.thumbprint}"
  }
}
