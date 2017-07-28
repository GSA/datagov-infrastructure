# terraforming sn

resource "aws_subnet" "subnet-e2f0f2ab-vpc-975987f1-internal-us-west-2a" {
    vpc_id                  = "vpc-975987f1"
    cidr_block              = "10.100.10.0/24"
    availability_zone       = "us-west-2a"
    map_public_ip_on_launch = false

    tags {
        "aws:cloudformation:stack-id" = "arn:aws:cloudformation:us-west-2:587807691409:stack/Spinnaker/1754aa50-7397-11e7-9652-50d5ca789eae"
        "aws:cloudformation:logical-id" = "SpinnakerPublicSubnet"
        "app" = "spinnaker"
        "aws:cloudformation:stack-name" = "Spinnaker"
        "Name" = "vpc-975987f1.internal.us-west-2a"
    }
}

resource "aws_subnet" "subnet-86f1f3cf-vpc-975987f1-internal-us-west-2a" {
    vpc_id                  = "vpc-975987f1"
    cidr_block              = "10.100.11.0/24"
    availability_zone       = "us-west-2a"
    map_public_ip_on_launch = false

    tags {
        "Name" = "vpc-975987f1.internal.us-west-2a"
        "app" = "spinnaker"
        "aws:cloudformation:stack-name" = "Spinnaker"
        "aws:cloudformation:logical-id" = "SpinnakerPrivateSubnet"
        "aws:cloudformation:stack-id" = "arn:aws:cloudformation:us-west-2:587807691409:stack/Spinnaker/1754aa50-7397-11e7-9652-50d5ca789eae"
    }
}

