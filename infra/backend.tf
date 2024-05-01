terraform {
  backend "s3" {
    bucket = "fiap-tfstates"
    key    = "api-gtw-auth/terraform.tfstate"
    region = "us-east-1"
  }
}
