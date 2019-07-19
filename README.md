_This repo is no longer maintained. Please follow https://github.com/GSA/datagov-deploy for more information about our
infrastructure plans._

# datagov-infrastructure

<img src="https://img.shields.io/badge/Project%20Phase-Alpha-red.svg" />

This repo contains the Work in Progress (WIP) for Data.gov's Infrastructure as Code using Terraform. Using Jenkins, Terraform, Packer to deploy [Data.gov's Production Deployment](https://github.com/gsa/catalog-deploy).

## Repository Contents

Main directories:
* deprecated - legacy code used for reference
* docker - a dockerized jenkins used for testing
* opencontrol - security documentation in the [Open Control format](https://github.com/opencontrol)
* terraform - terraform is used to provision AWS infrastructure and resources, this folder contains terraform modules (reusable terraform code) to provision the VPC, Subnets, Security Groups, Route tables, etc to setup the Networking and architecture of Data.gov's production environmnet  

## Quick start

1. [Install Terraform](https://www.terraform.io/intro/getting-started/install.html).

1. [Install Terragrunt](https://github.com/gruntwork-io/terragrunt/releases) using the appropriate package for you OS. You can also install via these methods:
     * OSX - install Terragrunt on OSX using [Homebrew](https://brew.sh/): `brew install terragrunt`.
     * Linux - install Terragrunt on Linux systems using [snap](https://snapcraft.io/docs/core/install): `snap install terragrunt`.
     * Manually/Windows - install Terragrunt manually by going to the [Releases Page](https://github.com/gruntwork-io/terragrunt/releases), downloading the binary for your OS, renaming it to `terragrunt`, and adding it to your PATH (root directory here).

1. Go into the [`terraform`](/terraform) folder and edit the `terraform.tfvars` file which start with `terragrunt = { ... }` block that contains the main configuration for Terragrunt and variables for Terraform (check out the [terragrunt](#terragrunt) section for addition types of configuration Terragrunt supports):

    terragrunt uses [hashicorp hcl](https://github.com/hashicorp/hcl) 
    ```
    terragrunt = {
      # (put your Terragrunt configuration here)
    }
    ```

1. Now, instead of running `terraform` directly, run all the standard Terraform commands using `terragrunt`:

    ```bash
    terragrunt get
    terragrunt plan
    terragrunt apply
    terragrunt output
    terragrunt destroy
    ```

   Terragrunt forwards almost all commands, arguments, and options directly to Terraform, using whatever version of Terraform have installed. However, based on the settings in your `terraform.tfvars` file, Terragrunt can configure remote state, locking, extra arguments, and lots more.

> Terragrunt is a direct implementation of the ideas expressed in 
   [Terraform: Up & Running](http://www.terraformupandrunning.com). Additional background reading that will help
   explain the motivation for Terragrunt includes the Gruntwork.io blog posts
   [How to create reusable infrastructure with Terraform modules](https://blog.gruntwork.io/how-to-create-reusable-infrastructure-with-terraform-modules-25526d65f73d)
   and [How to use Terraform as a team](https://blog.gruntwork.io/how-to-use-terraform-as-a-team-251bc1104973).

## Contributing
We're so glad you're thinking about contributing to Data.gov!

Before contributing to Data.gov we encourage you to read our [CONTRIBUTING](https://github.com/GSA/data.gov/blob/master/CONTRIBUTING.md) guide, our [LICENSE](https://github.com/GSA/data.gov/blob/master/LICENSE.md), and our README (you are here), all of which should be in this repository. If you have any questions, you can email the Data.gov team at [datagov@gsa.gov](mailto:datagov@gsa.gov).
