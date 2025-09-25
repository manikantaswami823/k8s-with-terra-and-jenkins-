module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.15.1"

  cluster_name                  = local.name
  cluster_version               = "1.32"                # specify Kubernetes version
  cluster_endpoint_public_access = true

  cluster_addons = {
    coredns = {
      version     = "v1.12.0-eksbuild.1"              # compatible add-on version
      most_recent = false
    }
    kube_proxy = {
      version     = "v1.32.1-eksbuild.1"
      most_recent = false
    }
    vpc_cni = {
      version     = "v1.12.2-eksbuild.1"
      most_recent = false
    }
  }

  vpc_id                   = module.vpc.id              # correct output from your VPC module
  subnet_ids               = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.intra_subnets

  eks_managed_node_group_defaults = {
    instance_types                        = ["m4.large"]
    attach_cluster_primary_security_group = true
    ami_type                              = "CUSTOM"        # CUSTOM lets EKS choose the correct AL2 for v1.33
  }

  eks_managed_node_groups = {
    k8s-stagingggg = {
      min_size      = 1
      max_size      = 2
      desired_size  = 1
      instance_types = ["t3.large"]
      capacity_type  = "SPOT"
      tags = {
        ExtraTag = "Helloworld"
      }
    }
  }
}
