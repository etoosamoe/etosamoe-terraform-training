output "public_ip_bastion" {
  value = module.infra.public_ip_bastion
}

output "public_ip_k8s_master" {
  value = module.infra.public_ip_k8s_master
}

output "public_ip_k8s_worker" {
  value = module.infra.public_ip_k8s_worker
}