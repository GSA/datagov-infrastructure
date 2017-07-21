# ---------------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# 
# This is the configuration for Terragrunt, a thin wrapper for Terraform that supports locking and enforces best
# practices: https://github.com/gsa/terragrunt
# 
# It assumes your aws credentials are located at `~/.aws/credentials` 
# ---------------------------------------------------------------------------------------------------------------------

terragrunt = {
  # Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
  # working directory, into a temporary folder, and execute your Terraform commands in that folder.
  terraform {
    source = "/modules"
  }

  # Include all settings from the `stack` terraform.tfvars file(s)
  include = {
    path = "${find_in_parent_folders()}"
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# Global Variables
# 
# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
# ---------------------------------------------------------------------------------------------------------------------

system_name = "datagov-infrastructure"
system_aws_subaccount = "XXXXXXXXX"

# Default values overwritten by terraform.tfvars within `stack`
aws_region = "us-east-1"

#TODO multi-region
#aws_region_1 = "us-east-1"
#aws_region_2 = "us-west-1"

instance_ami = "ami-xxxxxxx"
instance_type = "t2.medium"

#For reference only
#instance_type_compute_medium = "c4.xlarge"
#instance_type_compute_large = "c4.2xlarge"
#instance_type_memory_medium = "m4.xlarge"
#instance_type_memory_large = "m4.2xlarge"

instance_min_size = 1
instance_max_size = 2

instance_server_port = 8080

elb_port    = 443