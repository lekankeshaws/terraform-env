

# Declaring local values

locals {
  vpc_id = aws_vpc.dev_vpc.id
  azs    = data.aws_availability_zones.available.names
}


# locals {
#   subnet_name = aws_subnet.public1[count.index]
# }