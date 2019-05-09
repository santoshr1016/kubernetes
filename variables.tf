variable "aws_profile" {
  default     = "default"
  description = "Amazon Account Profile to Use"
}

variable "is_kubernetes_core_ami" {
  default = "ami-04ea7cb66af82ae4a"
}

//  Availability zones for each region
variable "aws_availability_zones" {
  default = {
    //  N. Virginia
    us-east-1 = [
      "us-east-1a",
      "us-east-1b",
      "us-east-1c",
      "us-east-1d",
      "us-east-1e",
      "us-east-1f",
    ]

    //ohio
    us-east-2 = [
      "us-east-2a",
      "us-east-2b",
      "us-east-2c",
    ]

    //  Oregon
    us-west-2 = [
      "us-west-2a",
      "us-west-2b",
      "us-west-2c",
    ]
  }
}

variable "map_users" {
  description = "Additional IAM users to add to the aws-auth configmap."
  type        = "list"

  default = [
    {
      user_arn = "arn:aws:iam::993257197638:user/abhishek.ab"
      username = "abhishek.ab"
      group    = "system:masters"
    },
    {
      user_arn = "arn:aws:iam::993257197638:user/sai.singh"
      username = "sai.singh"
      group    = "system:masters"
    },
  ]
}