terraform {
  backend "s3" {
    bucket = "tfstate-fiap"
    key    = "api-gtw-auth/terraform.tfstate"
    region = "us-east-1"

  }
}
