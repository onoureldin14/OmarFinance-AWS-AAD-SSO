# variable "users" {
#   description = "Map of users to create and their role"
#   type = map(object({
#     user_principal_name = string
#     display_name        = string
#     mail_nickname       = string
#     role                = string
#   }))
# }

# variable "prefix" {
#   type        = string
#   description = "Prefix for resources, used to avoid name collisions"
#   default     = "control-tower-aws-aad-sso"
# }

# variable "aws_saml_entity_id" {
#   type        = string
#   description = "AWS SAML Entity ID, Copy the IAM Identity Center issuer URL"
# }

# variable "aws_saml_acs" {
#   type        = string
#   description = "AWS SAML Assertion Consumer Service URL, Copy the IAM Identity Center ACS URL"
# }
