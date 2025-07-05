variable "john_user_email" {
  type        = string
  description = "User principal name for John Doe"
}
variable "jane_user_email" {
  type        = string
  description = "User principal name for Jane Doe"
}

variable "alex_user_email" {
  type        = string
  description = "User principal name for Alexandru Popa"
}
variable "oladele_user_email" {
  type        = string
  description = "User principal name for Oladele Oloruntimilehin"
}

variable "aws_app_prefix" {
  type        = string
  description = "Prefix for resources, used to avoid name collisions"
  default     = "control-tower-aws-aad-sso"
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

variable "aws_sso_loging_url" {
  type        = string
  description = "AWS SSO Login URL"
  sensitive   = true
}

variable "enable_teleport" {
  type        = bool
  description = "variable to enable the teleport integration"
  default     = true
}

variable "teleport_app_prefix" {
  type        = string
  description = "Prefix for resources, used to avoid name collisions"
  default     = "control-tower-teleport"
}

variable "teleport_saml" {
  type        = string
  description = "SAML entity ID and Assertion Consumer Service URL for the Teleport SSO instance"
  sensitive   = true
}
