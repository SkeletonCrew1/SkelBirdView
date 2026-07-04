# What is and how to run?
# What is?
It is a Terraform code that creates users that are only temporary and will be deleted after. I decided that it is a nice decision to keep them in a separate state file for easier organizing.
## Prerequisites
* Have Git installed
* Have Terraform installed
* Have enough AWS permissions to deploy everything in this code
## How To run?
* Run `aws configure` and then type-in your access key and secret access key (this must be credentials for a user with enough permissions to perform all the actions in this code)
* Clone this reposiotory using `git clone <repository URL>`
* Use `cd <path-to-copied-repository>/main/terraform/tmo-users`
* Run `terraform apply --auto-approve` and wait for the command to be over