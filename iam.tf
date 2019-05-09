resource "aws_iam_policy" "AbhishekK8sExternalDNSPolicy" {
  name        = "Abhishek-Kubernetes-ExternalDNSPolicy"
  path        = "/"
  description = "Allows EKS nodes to modify Route53 to support ExternalDNS."

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "route53:ListHostedZones",
                "route53:ListResourceRecordSets",
                "route53:ListHostedZonesByName"
            ],
            "Resource": ["*"]
        },
        {
            "Effect": "Allow",
            "Action": [
                "route53:ChangeResourceRecordSets"
            ],
            "Resource": ["*"]
        },
        {
            "Effect": "Allow",
            "Action": [
                "route53:GetChange"
            ],
            "Resource": ["*"]
        }
    ]
}
EOF
}


resource "aws_iam_policy_attachment" "abhishekeks-us-east-2-K8sExternalDNSPolicyAttachment" {
  name       = "Abhishek-Kubernetes-ExternalDNSPolicy-Attachment"
  roles      = ["${module.internal-services-abhishekeks-us-east-2.worker_iam_role_name}"]
  policy_arn = "${aws_iam_policy.AbhishekK8sExternalDNSPolicy.arn}"
}
