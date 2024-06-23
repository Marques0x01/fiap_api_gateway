terraform {
  backend "s3" {
    bucket = "fiap-backend"
    key    = "api-gtw-auth/terraform.tfstate"
    region = "us-east-1"
  }
}
