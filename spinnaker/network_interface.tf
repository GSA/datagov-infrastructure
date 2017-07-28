# terraforming nif

resource "aws_network_interface" "eni-4fe80171" {
    subnet_id         = "subnet-e2f0f2ab"
    private_ips       = ["10.100.10.89"]
    security_groups   = ["sg-9f79f7e5"]
    source_dest_check = true
    attachment {
        instance     = "i-0018bfe6381591aad"
        device_index = 0
    }
}

resource "aws_network_interface" "eni-d6947de8" {
    subnet_id         = "subnet-e2f0f2ab"
    private_ips       = ["10.100.10.107"]
    security_groups   = []
    source_dest_check = false
}

resource "aws_network_interface" "eni-13ea032d" {
    subnet_id         = "subnet-e2f0f2ab"
    private_ips       = ["10.100.10.172"]
    security_groups   = ["sg-a87df3d2"]
    source_dest_check = true
    attachment {
        instance     = "i-0b8667f4a900ce4c1"
        device_index = 0
    }
}

