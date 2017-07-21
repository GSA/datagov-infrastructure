# ---------------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# This is the configuration for Terragrunt, a thin wrapper for Terraform that supports locking and enforces best
# practices: https://github.com/gsa/terragrunt
# ---------------------------------------------------------------------------------------------------------------------

terragrunt = {
  # Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
  # working directory, into a temporary folder, and execute your Terraform commands in that folder.
  terraform {
    source = "/modules"
  }

  # Include all settings from the root terraform.tfvars file
  include = {
    path = "${find_in_parent_folders()}"
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# MODULE PARAMETERS
# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
# ---------------------------------------------------------------------------------------------------------------------
name = "datagov-infrastructure"

aws_region_1 = "us-east-1"
aws_region_2 = "us-west-1"

instance_type = "t2.medium"

#instance_type_compute_medium = "c4.xlarge"
#instance_type_compute_large = "c4.2xlarge"
#instance_type_memory_medium = "m4.xlarge"
#instance_type_memory_large = "m4.2xlarge"

instance_min_size = 1
instance_max_size = 2

jenkins_server_port = 8080
elb_port    = 443