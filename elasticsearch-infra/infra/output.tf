output "public_ip_bastion" {
  value = aws_instance.bastion.public_ip
}

output "public_ip_es_nodes" {
  value = aws_instance.node.*.private_ip
}
