output "public_ip_1" {
    value = aws_instance.test_server["server_1"].public_ip
  
}

output "public_ip_2" {
    value = aws_instance.test_server["server_2"].public_ip
  
}

output "instance_id_1" {
    value = aws_instance.test_server["server_1"].id
  
}

output "instance_id_2" {
    value = aws_instance.test_server["server_2"].id
  
}

output "all_public_subnet" {
    value = [for sub in aws_subnet.public_subnet: sub.id]
  
}