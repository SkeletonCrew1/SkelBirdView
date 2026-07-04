# What is and how to run?
# What is?
It is a Terraform code that:
* Creates security group for Consul EC2 machine.
* EC2 machine for Consul to run on.
* It is deployed on a public subnet of our custom VPC (ids of all this is taken from a tfstate file and is accessed in data.tf).
* !!! Meanwhile it is just an empty EC2 instance, it is important that this machine specifically is utilized to run Consul as security groups are tuned specifically for that.
## Prerequisites
* Have Git installed
* Have Terraform installed
* Have enough AWS permissions to deploy everything in this code
## How To run?
* Run `aws configure` and then type-in your access key and secret access key (this must be credentials for a user with enough permissions to perform all the actions in this code)
* Clone this reposiotory using `git clone <repository URL>`
* Use `cd <path-to-copied-repository>/main/terraform/consul`
* Run `terraform apply --auto-approve` and wait for the command to be over