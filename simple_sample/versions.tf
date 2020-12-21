terraform {
  required_version = "~> 0.14"
  required_providers {
    aws = {
      version = "~> 3.21"
    }
  }
}
provider "aws" {
  // profile  = "customprofile"
  //
  // OR
  //
  //  access_key = "my-access-key"
  //  secret_key = "my-secret-key"

  region = "us-east-1"
}