# terraforming r53z

resource "aws_route53_zone" "devops-datagov-us-public" {
    name       = "devops.datagov.us"
    comment    = ""

    tags {
    }
}

# terraforming r53r