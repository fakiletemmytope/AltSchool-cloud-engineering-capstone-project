# aws_eks_addon.eks-capstone-coredns:
resource "aws_eks_addon" "eks-capstone-coredns" {
    addon_name               = "coredns"
    addon_version            = "v1.11.1-eksbuild.8"
    cluster_name             = aws_eks_cluster.capstone_project.name
    depends_on = [aws_eks_cluster.capstone_project]
}

# aws_eks_addon.eks-capstone-kube-proxy:
resource "aws_eks_addon" "eks-capstone-kube-proxy" {
    addon_name               = "kube-proxy"
    addon_version            = "v1.30.0-eksbuild.3"
    cluster_name             = aws_eks_cluster.capstone_project.name
    depends_on = [aws_eks_cluster.capstone_project]
}

# aws_eks_addon.eks-capstone-pod-identity-agent:
resource "aws_eks_addon" "eks-capstone-pod-identity-agent" {
    addon_name               = "eks-pod-identity-agent"
    addon_version            = "v1.3.0-eksbuild.1"
    cluster_name             = aws_eks_cluster.capstone_project.name
    depends_on = [aws_eks_cluster.capstone_project]
}

# aws_eks_addon.eks-capstone-vpc-cni:
resource "aws_eks_addon" "eks-capstone-vpc-cni" {
    addon_name               = "vpc-cni"
    addon_version            = "v1.18.1-eksbuild.3"
    cluster_name             = aws_eks_cluster.capstone_project.name
    depends_on = [aws_eks_cluster.capstone_project]
}