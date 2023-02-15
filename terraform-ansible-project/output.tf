

#########################################################
# CREATING OUTPUT BLOCK
#########################################################

output "public_ip" {
  value = aws_instance.ansible_worknodes.*.public_ip
}

