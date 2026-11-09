locals {

  env_suffix = terraform.workspace == "default" ? "" : "-${terraform.workspace}"

  environments = {

    default = {
      vpc_cidr      = "10.0.0.0/16"
      subnet_cidr   = "10.0.1.0/24"
      instance_type = "t2.micro"
    }

    dev = {
      vpc_cidr      = "10.10.0.0/16"
      subnet_cidr   = "10.10.1.0/24"
      instance_type = "t2.micro"
    }

    qa = {
      vpc_cidr      = "10.20.0.0/16"
      subnet_cidr   = "10.20.1.0/24"
      instance_type = "t2.small"
    }
  }

  env = local.environments[terraform.workspace]
}