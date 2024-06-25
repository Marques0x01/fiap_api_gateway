terraform {
  backend "s3" {
    bucket = "tfstates-fiap"
    key    = "api-gtw-auth/terraform.tfstate"
    region = "us-east-1"
  }
}
