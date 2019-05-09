module "abhishek-eks-vpc-us-east-2" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "1.60.0"

  name = "abhishek-eks-vpc-us-east-2"

  cidr = "10.0.0.0/16"

  secondary_cidr_blocks = [
    "10.1.0.0/16",
    "10.2.0.0/16",
  ]

  azs = [
    "${element(var.aws_availability_zones["us-east-2"], 0)}",
    "${element(var.aws_availability_zones["us-east-2"], 1)}",
    "${element(var.aws_availability_zones["us-east-2"], 2)}",
  ]

  public_subnets = [
    "10.0.0.0/18",
    "10.0.64.0/18",
    "10.0.128.0/18",
  ]

  private_subnets = [
    "10.1.0.0/18",
    "10.1.64.0/18",
    "10.1.128.0/18",
  ]

  elasticache_subnets = [
    "10.2.31.0/24",
    "10.2.32.0/24",
  ]

  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_nat_gateway = true
  single_nat_gateway = false

  //why this tag???
  public_subnet_tags = {
    "kubernetes.io/role/elb" = "1"
  }

  //why this tag???
  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = "1"
  }

  //why this tag???
  tags = "${merge(local.default_tags, map(
    "Name", "Abhishek EKS Cluster VPC",
    "kubernetes.io/cluster/abhishekeks-us-east-2", "shared"
    ))}"
}