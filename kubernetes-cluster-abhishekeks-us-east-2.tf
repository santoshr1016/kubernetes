module "internal-services-abhishekeks-us-east-2" {
  source  = "terraform-aws-modules/eks/aws"
  version = "3.0.0"

  cluster_name    = "abhishekeks-us-east-2"
  cluster_version = "1.12"

  cluster_endpoint_private_access = false
  cluster_endpoint_public_access  = true

  vpc_id = "${module.abhishek-eks-vpc-us-east-2.vpc_id}"

  subnets = [
    "${module.abhishek-eks-vpc-us-east-2.public_subnets[0]}",
    "${module.abhishek-eks-vpc-us-east-2.public_subnets[1]}",
    "${module.abhishek-eks-vpc-us-east-2.public_subnets[2]}",
    "${module.abhishek-eks-vpc-us-east-2.private_subnets[0]}",
    "${module.abhishek-eks-vpc-us-east-2.private_subnets[1]}",
    "${module.abhishek-eks-vpc-us-east-2.private_subnets[2]}",
  ]

  worker_group_count                 = "0"
  worker_group_launch_template_count = "1"
  worker_groups_launch_template      = "${local.internal-services-abhishekeks-us-east-2-worker-groups_launch_template}"
  cluster_enabled_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]


  map_users_count = "2"
  map_users       = "${var.map_users}"

  config_output_path = ".kube_config/"
  tags               = "${merge(local.default_tags)}"
}

locals {
  internal-services-abhishekeks-us-east-2-worker-groups_launch_template = [
    {
      name                   = "abhishekeks-us-east-2-worker-group-1"
      instance_type          = "c5.large"
      override_instance_type = "c5.xlarge"
      ami_id                 = "${var.is_kubernetes_core_ami}"

      asg_desired_capacity = "1"
      asg_min_size         = "1"
      asg_max_size         = "3"
      asg_force_delete     = true
      root_volume_size     = "50"
      root_encrypted       = ""

      subnets   = "${module.abhishek-eks-vpc-us-east-2.public_subnets[0]}"
      public_ip = true

      autoscaling_enabled   = true
      protect_from_scale_in = true

      spot_allocation_strategy                 = "lowest-price"
      spot_instance_pools                      = 10
      on_demand_percentage_above_base_capacity = "0"

      kubelet_extra_args = "--node-labels=function=ingress,kubernetes.io/role=Ingress,lifecycle=Ec2Spot"
    }
  ]
}