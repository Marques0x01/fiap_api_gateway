terraform {
  backend "s3" {
    bucket = "backend-projeto"
    key    = "api-gtw-auth/terraform.tfstate"
    region = "us-east-2"
  }
}
