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
  // export AWS_ACCESS_KEY_ID="anaccesskey"
  // export AWS_SECRET_ACCESS_KEY="asecretkey"

  region = "us-east-1"
}