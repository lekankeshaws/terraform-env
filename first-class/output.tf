

########### OUTPUT Block ############
output "instance_id" {
  value       = aws_instance.test_server.*.id
  description = "output the instance id of the server"
}

output "public_ip" {
  description = "output the public ip"
  value       = aws_instance.test_server.*.public_ip

}

output "privateip" {
  description = "Output the private ip of ec2 instance"
  value       = aws_instance.test_server.*.private_ip
}

output "private_subnet_id" {
  description = "output the subnet id"
  value       = aws_subnet.private1.*.id
}