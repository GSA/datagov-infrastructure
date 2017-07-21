# ---------------------------------------------------------------------------------------------------------------------
# A SIMPLE EXAMPLE OF HOW DEPLOY AN ASG WITH AN ELB IN FRONT OF IT
#
# This is an example of how to use Terraform to deploy an Auto Scaling Group (ASG) with an Elastic Load
# Balancer (ELB) in front of it. To keep the example simple, we deploy a vanilla Ubuntu AMI across the ASG and run a
# dirt simple "web server" on top of it as a User Data script. The "web server" always returns "Hello, World".
#
# Note: This code is meant solely as a simple demonstration of how to lay out your files and folders with Terragrunt
# in a way that keeps your Terraform code DRY. This is not production-ready code, so use at your own risk.
# ---------------------------------------------------------------------------------------------------------------------

provider "aws" {
  region = "${var.aws_region}"
}

terraform {
  # The configuration for this backend will be filled in automatically by Terragrunt
  backend "s3" {}
}

# ---------------------------------------------------------------------------------------------------------------------
# CREATE THE ASG
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_autoscaling_group" "${var.instance_name}" {
  launch_configuration = "${aws_launch_configuration.${var.instance_name}.id}"
  availability_zones   = ["${data.aws_availability_zones.all.names}"]

  load_balancers    = ["${aws_elb.${var.instance_name}.name}"]
  health_check_type = "ELB"

  min_size = "${var.instance_min_size}"
  max_size = "${var.instance_max_size}"

  tag {
    key                 = "Name"
    value               = "${var.system_name}"
    propagate_at_launch = true
  }
}

data "aws_availability_zones" "all" {}

# ---------------------------------------------------------------------------------------------------------------------
# CREATE THE LAUNCH CONFIGURATION
#
# This defines what runs on each EC2 Instance in the ASG. To keep the example simple, we run a plain Ubuntu AMI and
# configure a User Data scripts that runs a dirt-simple "Hello, World" web server. In real-world usage, you'd want to
# package the web server code into a custom AMI (rather than shoving it into User Data) and pass in the ID of that AMI
# as a variable.
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_launch_configuration" "${var.instance_name}" {
  image_id        = "${var.instance_ami}"
  instance_type   = "${var.instance_type}"
  security_groups = ["${aws_security_group.asg.id}"]

  lifecycle {
    create_before_destroy = true
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# CREATE A SECURITY GROUP FOR THE ASG
# 
# To keep the example simple, we configure the EC2 Instances to allow inbound traffic from anywhere. In real-world
# usage, you should lock the Instances down so they only allow traffic from trusted sources (e.g. the ELB).
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_security_group" "asg" {
  name = "${var.system_name}-${var.instance_name}-asg"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "asg_allow_http_inbound" {
  type              = "ingress"
  from_port         = "${var.instance_port}"
  to_port           = "${var.instance_port}"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.asg.id}"
}

# ---------------------------------------------------------------------------------------------------------------------
# CREATE AN ELB TO ROUTE TRAFFIC ACROSS THE ASG
#
# TODO - change this to use https and ALB - https://www.terraform.io/docs/providers/aws/d/iam_server_certificate.html
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_elb" "${var.instance_name}" {
  name               = "${var.system_name}-${var.instance_name}"
  availability_zones = ["${data.aws_availability_zones.all.names}"]
  security_groups    = ["${aws_security_group.elb.id}"]

  listener {
    lb_port           = "${var.elb_port}"
    lb_protocol       = "http"
    instance_port     = "${var.server_port}"
    instance_protocol = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
    target              = "HTTP:${var.server_port}/"
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# CREATE A SECURITY GROUP FOR THE ELB
# 
# To keep the example simple, we configure the ELB to allow inbound requests from anywhere. We also allow it to make
# outbound requests to anywhere so it can perform health checks. In real-world usage, you should lock the ELB down
# so it only allows traffic to/from trusted sources. 
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_security_group" "elb" {
  name = "${var.instance_name}-elb"
}

resource "aws_security_group_rule" "elb_allow_http_inbound" {
  type              = "ingress"
  from_port         = "${var.elb_port}"
  to_port           = "${var.elb_port}"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.elb.id}"
}

resource "aws_security_group_rule" "elb_allow_all_outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.elb.id}"
}