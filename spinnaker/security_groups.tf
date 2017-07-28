# terraforming sg

resource "aws_security_group" "vpc-975987f1-default" {
    name        = "default"
    description = "default VPC security group"
    vpc_id      = "vpc-975987f1"

    ingress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        security_groups = []
        self            = true
    }


    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }

}

resource "aws_security_group" "vpc-975987f1-Spinnaker-SpinnakerWebServerSecurityGroup-156E6V2NOSK0F" {
    name        = "Spinnaker-SpinnakerWebServerSecurityGroup-156E6V2NOSK0F"
    description = "Security Group for Spinnaker Web server"
    vpc_id      = "vpc-975987f1"

    ingress {
        from_port       = 22
        to_port         = 9000
        protocol        = "tcp"
        security_groups = ["sg-a87df3d2"]
        self            = false
    }


    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }

    tags {
        "app" = "spinnaker"
        "aws:cloudformation:stack-id" = "arn:aws:cloudformation:us-west-2:587807691409:stack/Spinnaker/1754aa50-7397-11e7-9652-50d5ca789eae"
        "aws:cloudformation:stack-name" = "Spinnaker"
        "aws:cloudformation:logical-id" = "SpinnakerWebServerSecurityGroup"
        "Name" = "SpinnakerWebServerSecurityGroup"
    }
}

resource "aws_security_group" "vpc-975987f1-Spinnaker-SpinnakerBastionSecurityGroup-14XOHOQOJVED0" {
    name        = "Spinnaker-SpinnakerBastionSecurityGroup-14XOHOQOJVED0"
    description = "Enable SSH access via port 22"
    vpc_id      = "vpc-975987f1"

    ingress {
        from_port       = 22
        to_port         = 22
        protocol        = "tcp"
        cidr_blocks     = ["0.0.0.0/0"]
    }


    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }

    tags {
        "aws:cloudformation:stack-id" = "arn:aws:cloudformation:us-west-2:587807691409:stack/Spinnaker/1754aa50-7397-11e7-9652-50d5ca789eae"
        "app" = "spinnaker"
        "aws:cloudformation:stack-name" = "Spinnaker"
        "Name" = "SpinnakerBastionSecurityGroup"
        "aws:cloudformation:logical-id" = "SpinnakerBastionSecurityGroup"
    }
}
