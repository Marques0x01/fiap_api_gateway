terraform {
  backend "s3" {
    bucket = "backend-fiap"
    key    = "api-gtw-auth/terraform.tfstate"
    region = "us-east-2"
  }
}
