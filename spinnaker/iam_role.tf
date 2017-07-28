# terraforming iamrp

resource "aws_iam_role_policy" "Spinnaker-SpinnakerRole-TIV7OOPIH1OX_Spinnakerpassrole" {
    name   = "Spinnakerpassrole"
    role   = "Spinnaker-SpinnakerRole-TIV7OOPIH1OX"
    policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "iam:PassRole"
      ],
      "Resource": "arn:aws:iam::587807691409:role/Spinnaker-BaseIAMRole-LYY6FA6IL0GC",
      "Effect": "Allow",
      "Sid": "Stmt1449267121000"
    }
  ]
}
POLICY
}

# terraforming iampa

resource "aws_iam_role" "Spinnaker-BaseIAMRole-LYY6FA6IL0GC" {
    name               = "Spinnaker-BaseIAMRole-LYY6FA6IL0GC"
    path               = "/"
    assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role" "Spinnaker-SpinnakerRole-TIV7OOPIH1OX" {
    name               = "Spinnaker-SpinnakerRole-TIV7OOPIH1OX"
    path               = "/"
    assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}