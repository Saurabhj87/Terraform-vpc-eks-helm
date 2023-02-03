provider "aws" {
  region = var.region
}

locals {
  tags = {

    Example = "test-27jan"
    Name    = "Test-cluster"
  }
}
module "vpc" {
  #  source                  = "./modules/vpc"
  source                     = "github.com/Saurabhj87/vnet-tf-module"
  cidr_range                 = "10.0.0.0/16"
  vpc-public-subnet-cidr     = ["10.0.1.0/24", "10.0.2.0/24"]
  vpc-private-subnet-cidr    = ["10.0.3.0/24", "10.0.4.0/24"]
  availability_zone          = ["ap-south-1a", "ap-south-1b"]
  map_public_ip_on_launch    = true
  total-nat-gateway-required = "1"
  tags                       = local.tags
}

module "eks" {
  source             = "github.com/Saurabhj87/eks-tf-module"
  subnet_private_ids = ["${module.vpc.private_subnet_id[0]}", "${module.vpc.private_subnet_id[1]}"]
  #  subnet_private_ids = [ "subnet-0846ca80e3bbdccbf", "subnet-0ecf39feb652b7b28" ]
  eks_iam_role_name = "Test-role-for-eks"
  eks_cluster_name  = "test-cluster-eks"
  tags              = local.tags
}

resource "local_file" "kubeconfig" {
  content  = module.eks.kubeconfig
  filename = "/tmp/config"
}

