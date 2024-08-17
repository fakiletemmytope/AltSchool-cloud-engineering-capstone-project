terraform {
  backend "s3" {
    bucket         = "terraformstatesbackend"
    key            = "eks-cluster-capstone/terraform.tfstate"  # Unique key for the network configuration
    region         = "us-east-1"
    # dynamodb_table = "terraform-lock"  # Optional: Table for state locking
    # encrypt        = true              # Optional: Enable server-side encryption
  }
}