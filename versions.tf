terraform {
  required_version = ">= 0.13"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.74.2"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.1.0"
    }
  }
}
