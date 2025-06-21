terraform {
  backend "s3" {
    bucket       = ""
    key          = "aws-aad-sso/terraform.tfstate"
    region       = "eu-west-1"
    use_lockfile = true
  }
}
