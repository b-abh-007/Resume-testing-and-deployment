terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  shared_credentials_files = ["~/.aws/credentials"]
#   profile                  = "admin"
  region = "me-central-1"
}