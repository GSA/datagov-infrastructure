
variable "system_name" {
  description = "Name of the System"
}

variable "system_aws_subaccount" {
  description = "System AWS Sub Account number"
}

variable "aws_region" {
  description = "The AWS region to deploy to (e.g. us-east-1)"
}

variable "instance_name" {
  description = "The name for the ASG. This name is also used to namespace all the other resources created by this module."
}

variable "instance_type" {
  description = "The type of EC2 Instnaces to run in the ASG (e.g. t2.micro)"
}

variable "instance_ami" {
  description = "The AWS image id (ami-xxxxxxx) to use "
}

variable "instance_min_size" {
  description = "The minimum number of EC2 Instances to run in the ASG"
}

variable "instance_max_size" {
  description = "The maximum number of EC2 Instances to run in the ASG"
}

variable "instance_server_port" {
  description = "The port number the web server on each EC2 Instance should listen on for HTTP requests"
}

variable "elb_port" {
  description = "The port number the ELB should listen on for HTTP requests"
}