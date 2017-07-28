# terraforming rta

resource "aws_route_table_association" "Spinnaker-Private-Route-Table-rtbassoc-da5d53a3" {
    route_table_id = "rtb-da6648bc"
    subnet_id = "subnet-86f1f3cf"
}

resource "aws_route_table_association" "Spinnaker-Public-Route-Table-rtbassoc-2e595757" {
    route_table_id = "rtb-df654bb9"
    subnet_id = "subnet-e2f0f2ab"
}

# terraforming rt

resource "aws_route_table" "Spinnaker-Private-Route-Table" {
    vpc_id     = "vpc-975987f1"

    route {
        cidr_block = "0.0.0.0/0"
    }

    tags {
        "aws:cloudformation:logical-id" = "SpinnakerPrivateRouteTable"
        "Name" = "Spinnaker Private Route Table"
        "app" = "spinnaker"
        "aws:cloudformation:stack-id" = "arn:aws:cloudformation:us-west-2:587807691409:stack/Spinnaker/1754aa50-7397-11e7-9652-50d5ca789eae"
        "aws:cloudformation:stack-name" = "Spinnaker"
    }
}

resource "aws_route_table" "rtb-45674923" {
    vpc_id     = "vpc-975987f1"

    tags {
    }
}

resource "aws_route_table" "Spinnaker-Public-Route-Table" {
    vpc_id     = "vpc-975987f1"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "igw-554bc232"
    }

    tags {
        "aws:cloudformation:logical-id" = "SpinnakerPublicRouteTable"
        "app" = "spinnaker"
        "aws:cloudformation:stack-name" = "Spinnaker"
        "aws:cloudformation:stack-id" = "arn:aws:cloudformation:us-west-2:587807691409:stack/Spinnaker/1754aa50-7397-11e7-9652-50d5ca789eae"
        "Name" = "Spinnaker Public Route Table"
    }
}
