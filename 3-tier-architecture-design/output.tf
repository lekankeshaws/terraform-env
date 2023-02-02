

output "public_subnet_ids" {
    value = aws_subnet.public_subnet[*].id  
}

output "ngw_id" {
    value = aws_nat_gateway.ngw.id  
}