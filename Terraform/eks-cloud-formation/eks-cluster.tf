data "aws_iam_role" "eks-cluster-role" {
  name = "eks-cluster-role"
}

resource "aws_eks_cluster" "capstone_project" {

  #required attributes
  name     = "eks-cluster-for-capstone-project"
  role_arn = data.aws_iam_role.eks-cluster-role.arn
  vpc_config {
    subnet_ids = split(",", aws_cloudformation_stack.eks_cloudformation_stack.outputs["SubnetIds"])
    endpoint_public_access    = true
    public_access_cidrs       = ["0.0.0.0/0"]
  }

  #optional attributes
  version  = "1.30"

  upgrade_policy {
    support_type = "STANDARD"
  }

  kubernetes_network_config {
    ip_family         = "ipv4"
    service_ipv4_cidr = "10.100.0.0/16"
  }

  access_config{
    authentication_mode = "API_AND_CONFIG_MAP"
    bootstrap_cluster_creator_admin_permissions = true
  
  }

  depends_on = [
    aws_cloudformation_stack.eks_cloudformation_stack
  ]
}