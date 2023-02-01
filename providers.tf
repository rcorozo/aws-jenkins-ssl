terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
    namecheap = {
      source = "namecheap/namecheap"
      version = "2.1.0"
    }
  }
}

provider "aws" {
  region  = var.region
}

provider "namecheap" {
  user_name = var.my_username
  api_user = var.my_username
  api_key = var.my_api_key
  # client_ip = "123.123.123.123"
  use_sandbox = false
}