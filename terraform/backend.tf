terraform {
  backend "s3" {
    bucket     = "mangone-s3-bucket/terraform/"
    key        = "deploy-vuejs-app-to-s3-cloudfront/terraform.tfstate"
    region     = var.region
    access_key = var.access_key
    secret_key = var.secret_key
  }
}