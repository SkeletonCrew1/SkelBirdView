# What is and how to run?
# What is?
It is a Terraform code that:
* Creates a custom VPC.
* Creates two public networks.
* Creates two private networks.
* Even tho it was not require I had an example code which created 2 of both of networks, so I decided to create two of them anyway, also we can (and we do) use two separate networks for redundancy in case if one AZ (availibility zones) goes down.
* Creates an internet gateway and NAT.
* Creates two routing groups, one is used to route public networks to internet through internet gateway and the other one to route private networks to internet through NAT, they are applied to public and private networks respectively.
## Prerequisites
* Have Git installed (2.55.0 or higher)
* Have Terraform installed (6.52.0 or higher)
* Have enough AWS permissions to deploy everything in this code
## How To run?
* Run `aws configure` and then type-in your access key and secret access key (this must be credentials for a user with enough permissions to perform all the actions in this code)
* Clone this reposiotory using `git clone <repository URL>`
* Use `cd <path-to-copied-repository>/main/terraform/vpc`
* Run `terraform apply --auto-approve` and wait for the command to be over