# terraform-env
My terraform journey

# terraform commands
- terraform init
- terraform plan
- terraform validate
- terraform apply
- terraform destroy
- terraform refresh
- terraform console
- terraform fmt --recursive
- terraform output
- terraform show -json tf.plan > tf.plan.json
- terraform state list
- terraform state rm
- terraform init reconfigure (used to move state file, when backend has been changed)

# Data types in Terraform
Data types in Terraform

" " = string
[] = List
80 = Number
bool = True/False
{} = map
[" "] = list(string)
[{}]	list(map)
{[]}	map(list)

# Types of Module (Root/Child)
# Classes of Modules( public / private modules)
# Modules that built specific company (stored in github)
# Public modules are https://github.com/terraform-aws-modules

# Count loop

How to slice slice(data.aws_availability_zones.available.names, 0, 3) # This shows how to slice first 3 string in a list. 
How to use length length(var.private_subnets_cidr) & 
How to use count.index var.private_subnets_cidr[count.index]
How to use element element(slice(data.aws_availability_zones.available.names, 0,2) count.index)
To output all attribute in a count use aws_subnet.private_subnet.[*].id

# FOR_EACH
When working with for key, if you are trying to output a resource you would need to specify the key for example aws_subnet.public_subnet["public_subnet_1"].id

for_each works best with local but if you are creating a module it is best practice to use variable block to create your for_each.

To output all the attribute in a particular list of resources you would need to iterate for example: value = [for id in aws_subnet.public_subnet: id.id] / [for subnet in aws_subnet.public_subnet : subnet.id] where id can be any given variable.

You can also out all attribute in a particular list of resouces using value = values(aws_iam_user.example)[*].arn.

# function documentation https://developer.hashicorp.com/terraform/language/functions

# Module
When calling a module use git::https://github/<repo id>/<repo name>.git e.g: git::https://github.com/lekankeshaws/vpc-module.git
When calling a module with tags use git::https://github/<repo id>/<repo name>.git?ref=<tag name> e.g: git::https://github.com/lekankeshaws/vpc-module.git?ref=v.1.0.0

# Drift
A drift in terraform is when a resource has been manually deleted from the console and still exist in the "terraform state list", you can handle/manage a drift by removing the resource with the terraform state rm <resource name and logical name> e.g "terraform state rm aws_vpc.this"


