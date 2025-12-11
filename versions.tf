terraform {
  required_version = ">= 1.5.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>6"
    }
    local = {
      source  = "hashicorp/local"
      version = ">= 2"
    }
  }
}
