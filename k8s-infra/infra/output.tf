output "public_ip_bastion" {
  value = aws_instance.bastion.public_ip
}

output "public_ip_k8s_master" {
  value = aws_instance.k8s-master.private_ip
}

output "public_ip_k8s_worker" {
  value = aws_instance.k8s-worker.private_ip
}