terraform {
  backend "s3" {
    bucket = "webapp-s3-tf-backend"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}