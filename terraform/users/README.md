# What is and how to run?
# What is?
It is a Terraform script that creates given users with given permissions. main.tf creates every user with every policy mentioned in locals.tf file
## Prerequisites
* Have Git installed (2.55.0 or higher)
* Have Terraform installed (6.52.0 or higher)
* Have enough AWS permissions to deploy everything in this code
## How To run?
* Run `aws configure` and then type-in your access key and secret access key (this must be credentials for a user with enough permissions to perform all the actions in this code)
* Clone this reposiotory using `git clone <repository URL>`
* Use `cd <path-to-copied-repository>/main/terraform/users`
* Run `terraform apply --auto-approve` and wait for the command to be over