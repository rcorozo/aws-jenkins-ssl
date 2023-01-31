data "aws_ami" "app_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = [var.ami_filter.name]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = [var.ami_filter.owner]
}

module "aws_vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.environment.name
  cidr = "${var.environment.network_prefix}.0.0/16"

  azs             = ["${var.region}a","${var.region}b","${var.region}c"]
  public_subnets  = ["${var.environment.network_prefix}.101.0/24", "${var.environment.network_prefix}.102.0/24", "${var.environment.network_prefix}.103.0/24"]

  enable_nat_gateway = true

  tags = {
    Terraform   = "true"
    Environment = var.environment.name
  }
}

module "aws_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.13.0"

  name = "${var.environment.name}-jenkins"

  vpc_id = module.aws_vpc.vpc_id

  ingress_rules       = ["http-80-tcp", "https-443-tcp", "ssh-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]

  egress_rules       = ["all-all"]
  egress_cidr_blocks = ["0.0.0.0/0"]
}


resource "aws_network_interface" "this" {
  subnet_id       = module.aws_vpc.public_subnets[0]
  security_groups = [module.aws_sg.security_group_id]
}

resource "aws_instance" "this" {
  ami                    = data.aws_ami.app_ami.id
  instance_type          = var.instance_type

  network_interface {
    network_interface_id = aws_network_interface.this.id
    device_index         = 0
  }

  tags = {
    Terraform = "true"
    Name      = "${var.environment.name}-${var.instance_name}"
  }
}