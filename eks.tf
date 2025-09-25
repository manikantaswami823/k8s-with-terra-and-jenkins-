module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "21.0.0"

  cluster_name    = "eks-staging-cluster"
  cluster_version = "1.32"  # Ensure AMI compatibility

  subnets = module.vpc.private_subnets
  vpc_id  = module.vpc.vpc_id

  node_groups = {
    k8s_stagingggg = {
      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 1

      instance_type = "t3.medium"
      ami_type      = "AL2_x86_64" # compatible with k8s 1.32
    }
  }

  tags = {
    Environment = "staging"
    Project     = "eks"
  }
}
