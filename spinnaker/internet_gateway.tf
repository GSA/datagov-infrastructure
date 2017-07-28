# terraforming igw

resource "aws_internet_gateway" "igw-554bc232" {
    vpc_id = "vpc-975987f1"

    tags {
        "app" = "spinnaker"
        "aws:cloudformation:stack-id" = "arn:aws:cloudformation:us-west-2:587807691409:stack/Spinnaker/1754aa50-7397-11e7-9652-50d5ca789eae"
        "aws:cloudformation:stack-name" = "Spinnaker"
        "aws:cloudformation:logical-id" = "SpinnakerInternetGateway"
    }
}
