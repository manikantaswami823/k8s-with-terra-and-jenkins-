terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.67"
    }
  }
}

provider "aws" {
  region = "us-east-1"  # Hardcoded region
}

locals {
  name      = "eks-staging-cluster"
  vpc_cidr  = "10.123.0.0/16"
  azs       = ["us-east-1a", "us-east-1b", "us-east-1c"]

  private_subnets = ["10.123.1.0/24", "10.123.2.0/24", "10.123.3.0/24"]
  public_subnets  = ["10.123.101.0/24", "10.123.102.0/24", "10.123.103.0/24"]
  # intra_subnets removed as VPC module doesn't support this
}
