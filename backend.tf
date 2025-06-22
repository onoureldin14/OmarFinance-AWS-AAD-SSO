terraform {
  backend "s3" {
    bucket       = "tfstate-aws-aad-sso8b1b129e"
    key          = "aws-aad-sso/terraform.tfstate"
    region       = "eu-west-1"
    use_lockfile = true
  }
}
