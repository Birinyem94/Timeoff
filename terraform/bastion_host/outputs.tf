# Public EC2 Instances - Bastion Host

output "ec2_bastion_public_instance_ids" {
  description = "List of IDs of instances"
  value       = aws_instance.bastion_host.id
}

## ec2_bastion_public_ip
output "ec2_bastion_eip" {
  description = "Elastic IP associated to the Bastion Host"
  value       = aws_eip.bastion_eip.public_ip
}
