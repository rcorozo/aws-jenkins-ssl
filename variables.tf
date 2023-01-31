variable "region" {
    default     = "us-east-1"
}

variable "instance_type" {
    default     = "t4g.micro"
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
    name  = "amzn2-ami-hvm-*-arm64-ebs"
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

variable "asg_sizes" {
  description = "Min and max ASG sizes"

  type = object({
    min_size = number
    max_size = number
  })

  default = {
      min_size = 1
      max_size = 2
  }
}