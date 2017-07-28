# terraforming vpc

resource "aws_vpc" "SpinnakerVPC" {
    cidr_block           = "10.100.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support   = true
    instance_tenancy     = "default"

    tags {
        "Name" = "SpinnakerVPC"
        "app" = "spinnaker"
        "aws:cloudformation:stack-id" = "arn:aws:cloudformation:us-west-2:587807691409:stack/Spinnaker/1754aa50-7397-11e7-9652-50d5ca789eae"
        "aws:cloudformation:stack-name" = "Spinnaker"
        "aws:cloudformation:logical-id" = "SpinnakerVPC"
        "VPC" = "Spinnaker VPC"
    }
}
