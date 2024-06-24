terraform {
  backend "s3" {
    bucket         = "wordpress-terraform-backend-bucket"
    key            = "terraform.tfstate"
    region         = "eu-west-2"  
    encrypt        = true
    dynamodb_table = "wordpress-terraform-lock"  
  }
}