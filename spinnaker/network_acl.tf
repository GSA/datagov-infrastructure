# terraforming nacl

resource "aws_network_acl" "acl-adfd9fcb" {
    vpc_id     = "vpc-975987f1"
    subnet_ids = ["subnet-e2f0f2ab", "subnet-86f1f3cf"]

    ingress {
        from_port  = 0
        to_port    = 0
        rule_no    = 100
        action     = "allow"
        protocol   = "-1"
        cidr_block = "0.0.0.0/0"
    }

    egress {
        from_port  = 0
        to_port    = 0
        rule_no    = 100
        action     = "allow"
        protocol   = "-1"
        cidr_block = "0.0.0.0/0"
    }

    tags {
    }
}

