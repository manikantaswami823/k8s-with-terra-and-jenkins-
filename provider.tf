terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.67" # pin to 4.x (works with eks 19.x and vpc 4.x)
    }
  }
}

provider "aws" {
  region = var.region
}

locals {
  name      = "eks-staging-cluster"
  vpc_cidr  = "10.123.0.0/16"
  azs       = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]

  private_subnets = ["10.123.1.0/24", "10.123.2.0/24", "10.123.3.0/24"]
  public_subnets  = ["10.123.101.0/24", "10.123.102.0/24", "10.123.103.0/24"]
  intra_subnets   = ["10.123.201.0/24", "10.123.202.0/24", "10.123.203.0/24"]
}
