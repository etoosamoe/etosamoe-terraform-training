output "public_ip_bastion" {
  value = module.infra.public_ip_bastion
}

output "private_ip_es_nodes" {
  value = module.infra.private_ip_es_nodes
}

output "public_ip_es_nodes" {
  value = module.infra.public_ip_es_nodes
}