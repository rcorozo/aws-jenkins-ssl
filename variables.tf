variable "region" {
    default     = "us-east-1"
}

variable "instance_type" {
    default     = "t3.small"
}

variable "instance_name" {
    default     = "master-jenkins"
}

variable "ami_filter" {
  type = object({
    name  = string
    owner = string
  })

  default = {
    name  = "amzn2-ami-hvm-*-x86_64-ebs"
    owner = "amazon"
  }
}

variable "environment" {
  type = object({
    name           = string
    network_prefix = string
  })

  default = {
    name           = "dev"
    network_prefix = "10.0"
  }
}

variable "my_domain" {}

variable "my_api_key" {}

variable "my_username" {}