# terraforming ec2

resource "aws_instance" "BastionServer" {
    ami                         = "ami-7172b611"
    availability_zone           = "us-west-2a"
    ebs_optimized               = false
    instance_type               = "t2.micro"
    monitoring                  = false
    key_name                    = "spinnaker-test"
    subnet_id                   = "subnet-e2f0f2ab"
    vpc_security_group_ids      = ["sg-a87df3d2"]
    associate_public_ip_address = true
    private_ip                  = "10.100.10.172"
    source_dest_check           = true

    root_block_device {
        volume_type           = "gp2"
        volume_size           = 8
        delete_on_termination = true
    }

    tags {
        "aws:cloudformation:stack-id" = "arn:aws:cloudformation:us-west-2:587807691409:stack/Spinnaker/1754aa50-7397-11e7-9652-50d5ca789eae"
        "aws:cloudformation:stack-name" = "Spinnaker"
        "aws:cloudformation:logical-id" = "BastionServer"
        "Name" = "BastionServer"
        "app" = "spinnaker"
    }
}

resource "aws_instance" "SpinnakerWebServer" {
    ami                         = "ami-21a26d41"
    availability_zone           = "us-west-2a"
    ebs_optimized               = false
    instance_type               = "m4.4xlarge"
    monitoring                  = false
    key_name                    = "spinnaker-test"
    subnet_id                   = "subnet-e2f0f2ab"
    vpc_security_group_ids      = ["sg-9f79f7e5"]
    associate_public_ip_address = true
    private_ip                  = "10.100.10.89"
    source_dest_check           = true

    root_block_device {
        volume_type           = "standard"
        volume_size           = 10
        delete_on_termination = true
    }

    tags {
        "Name" = "SpinnakerWebServer"
        "aws:cloudformation:logical-id" = "SpinnakerWebServer"
        "app" = "spinnaker"
        "aws:cloudformation:stack-name" = "Spinnaker"
        "aws:cloudformation:stack-id" = "arn:aws:cloudformation:us-west-2:587807691409:stack/Spinnaker/1754aa50-7397-11e7-9652-50d5ca789eae"
    }
}
