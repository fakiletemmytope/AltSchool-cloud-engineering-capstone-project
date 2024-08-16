data "aws_iam_role" "eks-node-group-role" {
  name = "eks-node-group-role"
}
resource "aws_eks_node_group" "eks-nodegroup-capstone" {
    node_group_name = "eks-nodegroup-capstone-project"

    #required
    cluster_name    = aws_eks_cluster.capstone_project.name
    node_role_arn   = data.aws_iam_role.eks-node-group-role.arn
    subnet_ids      = split(",", aws_cloudformation_stack.eks_cloudformation_stack.outputs["SubnetIds"])
    scaling_config {
        desired_size = 30
        max_size     = 30
        min_size     = 1
    }
    #required-end

    #optional
    capacity_type          = "ON_DEMAND"
    ami_type               = "AL2_x86_64"
    instance_types         = ["t2.micro"]
    update_config {
        max_unavailable = 20
    }

    remote_access {
            ec2_ssh_key               = "jenkins-server-key"
            source_security_group_ids = []
    }

    depends_on = [aws_eks_cluster.capstone_project]
}