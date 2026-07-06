# What is and how to run?
# What is?
It is a Terraform code that:
* Creates multiple security groups (load-balancer, web-servers and mysql server).
* Creates multiple EC2 instances. 2 for web servers, 1 for loab-balancer and 1 for mysql server.
* web servers and mysql server are deployed inside a private network, load-balancer is deployed inside a public network. All of them are on our custom VPC.
* !!! Meanwhile they are just empty EC2 instances, it is very important to configure them as they are inteded, because subnets and security groups are configured in a specific way.
## Prerequisites
* Have Git installed (2.55.0 or higher)
* Have Terraform installed (6.52.0 or higher)
* Have enough AWS permissions to deploy everything in this code
## How To run?
* Run `aws configure` and then type-in your access key and secret access key (this must be credentials for a user with enough permissions to perform all the actions in this code)
* Clone this reposiotory using `git clone <repository URL>`
* Use `cd <path-to-copied-repository>/main/terraform/application`
* Run `terraform apply --auto-approve` and wait for the command to be over