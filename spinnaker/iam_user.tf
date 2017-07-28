# terraforming iamu

resource "aws_iam_user" "Spinnaker-SpinnakerUser-1THVRDN03NMZL" {
    name = "Spinnaker-SpinnakerUser-1THVRDN03NMZL"
    path = "/"
}

# terraforming iamup

resource "aws_iam_user_policy" "ses-smtp-user-20161217-210124_AmazonSesSendingAccess" {
    name   = "AmazonSesSendingAccess"
    user   = "ses-smtp-user.20161217-210124"
    policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "ses:SendRawEmail",
      "Resource": "*"
    }
  ]
}
POLICY
}

resource "aws_iam_user_policy" "Spinnaker-SpinnakerUser-1THVRDN03NMZL_Spinnakerpassrole" {
    name   = "Spinnakerpassrole"
    user   = "Spinnaker-SpinnakerUser-1THVRDN03NMZL"
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

