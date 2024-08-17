resource "aws_cloudformation_stack" "eks_cloudformation_stack" {
  name         = "eks-worker-node-vpc"
  template_url = "https://s3.us-west-2.amazonaws.com/amazon-eks/cloudformation/2020-10-29/amazon-eks-vpc-private-subnets.yaml"
}

output "subnet_ids" {
  value = aws_cloudformation_stack.eks_cloudformation_stack.outputs["SubnetIds"]
}

output "vpc_id" {
  value = aws_cloudformation_stack.eks_cloudformation_stack.outputs["VpcId"]
}
# data "aws_cloudformation_stack" "vpc_stack" {
#   name = aws_cloudformation_stack.eks-aws_cloudformation_stack.name
# }

# output "vpc_id" {
#   value = aws_cloudformation_stack.eks-cloudformation-stack.outputs["VpcId"]
# }

# output "subnet_ids" {
#   value = aws_cloudformation_stack.eks-cloudformation-stack.outputs["SubnetIds"]
# }

# output "security_group_id" {
#   value = aws_cloudformation_stack.eks-cloudformation-stack.outputs["SecurityGroupId"]
# }

# # Convert comma-separated string to a list
# locals {
#   subnet_ids_list = split(",", aws_cloudformation_stack.eks-cloudformation-stack.outputs["SubnetIds"])
# }

# # Access individual subnets
# output "subnet1_id" {
#   value = local.subnet_ids_list[0]
# }

# output "subnet2_id" {
#   value = local.subnet_ids_list[1]
# }

# output "subnet3_id" {
#   value = local.subnet_ids_list[2]
# }

# output "subnet4_id" {
#   value = local.subnet_ids_list[3]
# }