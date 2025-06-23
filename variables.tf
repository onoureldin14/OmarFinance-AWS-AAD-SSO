variable "john_user_email" {
  type        = string
  description = "User principal name for John Doe"
}
variable "jane_user_email" {
  type        = string
  description = "User principal name for Jane Doe"
}

variable "aws_saml_entity_id" {
  type        = string
  description = "SAML entity ID for the AWS SSO instance"
  sensitive   = true
}

variable "aws_saml_acs" {
  type        = string
  description = "SAML Assertion Consumer Service URL for the AWS SSO instance"
  sensitive   = true
}
