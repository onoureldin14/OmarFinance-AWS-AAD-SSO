# variable "users" {
#   description = "Map of users to create and their role"
#   type = map(object({
#     user_principal_name = string
#     display_name        = string
#     mail_nickname       = string
#     role                = string
#   }))
# }

# variable "azure_app_roles" {
#   description = "Map of role key to display name/description for Azure App Roles"
#   type        = map(string)
# }


# variable "aws_saml_entity_id" {
#   type        = string
#   description = "AWS SAML Entity ID, Copy the IAM Identity Center issuer URL"
# }

# variable "aws_saml_acs" {
#   type        = string
#   description = "AWS SAML Assertion Consumer Service URL, Copy the IAM Identity Center ACS URL"
# }

variable "prefix" {
  type        = string
  description = "Prefix for resources, used to avoid name collisions"
  default     = "control-tower-aws-aad-sso"
}

variable "aws_saml_entity_id" {
  type        = string
  description = "AWS SAML entity ID for the IAM Identity Center SSO Application"
}

variable "aws_saml_acs" {
  type        = string
  description = "AWS SAML Assertion Consumer Service (ACS) URL"
}

variable "azure_app_roles" {
  description = "Map of Azure AD App roles"
  type        = map(string)
}

variable "logo_image_base64" {
  description = "Base64-encoded logo image for the Azure AD application"
  type        = string
}

variable "users" {
  description = "Map of user objects"
  type = map(object({
    user_principal_name = string
    display_name        = string
    mail_nickname       = string
    role                = string
    azure_ad_user_type  = string
    given_name          = optional(string, "")
    surname             = optional(string, "")
    email               = optional(string, "")
  }))
}
