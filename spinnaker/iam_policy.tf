# terraforming iampa

resource "aws_iam_policy_attachment" "PowerUserAccess-policy-attachment" {
    name       = "PowerUserAccess-policy-attachment"
    policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
    groups     = []
    users      = ["Spinnaker-SpinnakerUser-1THVRDN03NMZL"]
    roles      = ["Spinnaker-SpinnakerRole-TIV7OOPIH1OX"]
}

# terraforming iamip

resource "aws_iam_instance_profile" "Spinnaker-SpinnakerInstanceProfile-V32RDDWF51ME" {
    name  = "Spinnaker-SpinnakerInstanceProfile-V32RDDWF51ME"
    path  = "/"
    roles = ["Spinnaker-SpinnakerRole-TIV7OOPIH1OX"]
}
