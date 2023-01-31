

output "vpc-id" {
    description = "display the vpc id"
    value = module.vpc.vpc_id  
}

output "az_names" {
    description = "display all azs used"
    value = module.vpc.azs  
}

output "private-subnet" {
    description = "display private subnet ids"
    value = module.vpc.private_subnets  
}