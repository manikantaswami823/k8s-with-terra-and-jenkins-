module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.15.1"

  cluster_name                  = local.name
  cluster_endpoint_public_access = true

  cluster_addons = {
    coredns = { most_recent = true }
    kube_proxy = { most_recent = true }
    vpc_cni    = { most_recent = true }
  }

  vpc_id                 = module.vpc.vpc_id
  subnet_ids             = module.vpc.private_subnets   # Used private subnets for node groups
  control_plane_subnet_ids = module.vpc.private_subnets # No intra_subnets, use private subnets

  eks_managed_node_group_defaults = {
    ami_type                              = "AL2_X86_64"
    instance_types                         = ["m4.large"]
    attach_cluster_primary_security_group = true
  }

  eks_managed_node_groups = {
    k8s-stagingggg = {
      min_size     = 1
      max_size     = 2
      desired_size = 1

      instance_types = ["t3.large"]
      capacity_type  = "SPOT"

      tags = {
        ExtraTag = "Helloworld"
      }
    }
  }

  tags = {
    Environment = "staging"
    Project     = "eks"
  }
