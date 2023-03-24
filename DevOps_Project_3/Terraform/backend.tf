

terraform {
  backend "s3" {
    bucket = "duyna11-bucket"
    key = "eks/duyna_cluster_name/statefile"
    region = "ap-south-1"
  }
} 
