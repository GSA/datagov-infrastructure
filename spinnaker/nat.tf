# terraforming nat

resource "aws_nat_gateway" "nat-061f79a46653c6405" {
    allocation_id = "eipalloc-9cf911a1"
    subnet_id = "subnet-e2f0f2ab"
}

