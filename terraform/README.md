## Concepts

Consider the following file structure, which would define three environments with terraform(prod, qa, stage) with the same infrastructure in each one (an app, a MySQL database, and a VPC):

```
    ├── prod
    │   ├── app
    │   │   └── main.tf
    │   ├── mysql
    │   │   └── main.tf
    │   └── vpc
    │       └── main.tf
    ├── stage
    │   ├── app
    │   │   └── main.tf
    │   ├── mysql
    │   │   └── main.tf
    │   └── vpc
    │       └── main.tf
    └── dev
        ├── app
        │   └── main.tf
        ├── mysql
        │   └── main.tf
        └── vpc
            └── main.tf
```

The contents of each environment would be more or less identical, except perhaps for a few settings (e.g. the prod environment may run bigger or more servers). As the size of the infrastructure grows, having to maintain all of this duplicated code between environments becomes more error prone. You can reduce the amount of copy paste using
[Terraform modules](https://blog.gruntwork.io/how-to-create-reusable-infrastructure-with-terraform-modules-25526d65f73d), but even the code to instantiate a module and set up input variables, output variables, providers, and remote state can still create a lot of maintenance overhead.

How can you keep your Terraform code [DRY](https://en.wikipedia.org/wiki/Don%27t_repeat_yourself) so that you only
have to define it once, no matter how many environments you have?


#### Remote Terraform configurations

Terragrunt has the ability to download remote Terraform configurations. The idea is that you define the Terraform code for your infrastructure just once, in a single repo, called `modules`:

```
└── modules
    ├── vpc
    │   └── main.tf
    ├── subnet
    │   └── main.tf
    └── app
        └── main.tf
```

This repo contains typical Terraform code, with one difference: anything in your code that should be different between environments should be exposed as an input variable. For example, the `app` module might expose the following variables:

```hcl
variable "instance_count" {
  description = "How many servers to run"
}

variable "instance_type" {
  description = "What kind of servers to run (e.g. t2.large or c4.2xlarge)"
}
```

These variables allow you to run smaller/fewer servers in dev and stage to save money and larger/more servers in prod to ensure availability and scalability.

In a separate repo or directory, you define the code for all of your environments, which now consists of just one `.tfvars` file per component (e.g. `app/terraform.tfvars`, `mysql/terraform.tfvars`, etc). This gives you the following file layout:


```
    ├── prod
    │   ├── app
    │   │   └── terraform.tfvars
    │   ├── mysql
    │   │   └── terraform.tfvars
    │   └── vpc
    │       └── terraform.tfvars
    ├── stage
    │   ├── app
    │   │   └── terraform.tfvars
    │   ├── mysql
    │   │   └── terraform.tfvars
    │   └── vpc
    │       └── terraform.tfvars
    └── dev
        ├── app
        │   └── terraform.tfvars
        ├── mysql
        │   └── terraform.tfvars
        └── vpc
            └── terraform.tfvars
```

Notice how there are no Terraform configurations (`.tf` files) in any of the folders. Instead, each `.tfvars` file
specifies a `terraform { ... }` block that specifies from where to download the Terraform code/module, as well as the environment-specific values for the input variables in that Terraform code. For example,`stage/app/terraform.tfvars` may look like this:

```hcl
terragrunt = {
  terraform {
    #source = "git::git@github.com:foo/modules.git//app?ref=v0.0.3"
    source = "/modules/asg"
  }
}

instance_min_size = 1
instance_max_size = 2
instance_type = "t2.medium"
```

*(Note: the double slash (`//`) is intentional and required if you are using a remote repository. It's part of Terraform's Git syntax for [module
sources](https://www.terraform.io/docs/modules/sources.html).)*

And `prod/app/terraform.tfvars` may look like this:

```hcl
terragrunt = {
  terraform {
    #source = "git::git@github.com:foo/modules.git//app?ref=v0.0.1"
    source = "/modules/asg"
  }
}

instance_min_size = 2
instance_max_size = 6
instance_type = "c4.2xlarge"
```

Notice how the two `terraform.tfvars` files set the `source` URL to the same Auto-Scaling Group `asg` module, but at different versions (i.e. `stage` is testing out a newer version of the module). They also set the parameters for the `asg` module to different values that are appropriate for the environment: smaller/fewer servers in `stage`
to save money, larger/more instances in `prod` for scalability and high availability.