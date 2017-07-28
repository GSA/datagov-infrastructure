# terraforming eip

resource "aws_eip" "eipalloc-9cf911a1" {
    network_interface = "eni-d6947de8"
    vpc               = true
}
