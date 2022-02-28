resource "aws_security_group_rule" "ssh" {
  for_each = {
    "Etcd"    = aws_security_group.etcd.id,
    "Masters" = aws_security_group.master.id,
    "Workers" = aws_security_group.worker.id,
  }
  security_group_id        = each.value
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.bastion.id
  description              = "SSH: Bastion - ${each.key}"
}

### Bastion Host
resource "aws_security_group_rule" "allow_ingress_on_bastion_kubectl" {
  for_each = {
    "MasterPrivateLB" = aws_security_group.master-private-lb.id,
    "Masters"         = aws_security_group.master.id,
    "Workers"         = aws_security_group.worker.id
  }
  security_group_id        = each.value
  type                     = "ingress"
  from_port                = 6443
  to_port                  = 6443
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.bastion.id
  description              = "kubectl: Bastion - ${each.key}"
}

resource "aws_security_group_rule" "allow_ingress_bastion-lb_on_bastion_ssh" {
  security_group_id        = aws_security_group.bastion.id
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.bastion-lb.id
  description              = "SSH: Bastion-LB - Bastion"
}

### Bastion LB
resource "aws_security_group_rule" "allow_ingress_workstation_on_bastion-lb_ssh" {
  security_group_id = aws_security_group.bastion-lb.id
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["75.119.135.89/32"]
  description       = "SSH: Workstation - MasterPublicLB"
}

### MasterPublicLB
resource "aws_security_group_rule" "allow_ingress_workstation_on-master-public-lb_kubectl" {
  security_group_id = aws_security_group.master-public-lb.id
  type              = "ingress"
  from_port         = 6443
  to_port           = 6443
  protocol          = "tcp"
  cidr_blocks       = ["75.119.135.89/32"]
  description       = "kubectl: Workstation - MasterPublicLB"
}

### MasterPrivateLB
resource "aws_security_group_rule" "allow_ingress_on_master-private-lb_kubeapi" {
  security_group_id = aws_security_group.master-private-lb.id
  type              = "ingress"
  from_port         = 6443
  to_port           = 6443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "kubeapi: ALL - MasterPrivateLB"
}

### etcd
resource "aws_security_group_rule" "allow_etcd" {
  for_each = {
    "Masters" = aws_security_group.master.id,
    "Etcd"    = aws_security_group.etcd.id
  }
  security_group_id        = aws_security_group.etcd.id
  type                     = "ingress"
  from_port                = 2379
  to_port                  = 2380
  protocol                 = "tcp"
  source_security_group_id = each.value
  description              = "etcd: ${each.key} - Etcds"
}

### Master
resource "aws_security_group_rule" "allow_kubectl_on_master" {
  for_each = {
    "MasterPublicLB"  = aws_security_group.master-public-lb.id,
    "MasterPrivateLB" = aws_security_group.master-private-lb.id,
    "Workers"         = aws_security_group.worker.id
  }
  security_group_id        = aws_security_group.master.id
  type                     = "ingress"
  from_port                = 6443
  to_port                  = 6443
  protocol                 = "tcp"
  source_security_group_id = each.value
  description              = "kubectl: ${each.key} - Masters"
}

resource "aws_security_group_rule" "allow_ingress_worker_on_master_all" {
  security_group_id        = aws_security_group.master.id
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "all"
  source_security_group_id = aws_security_group.worker.id
  description              = "ALL: Workers - Masters"
}

### Worker
resource "aws_security_group_rule" "allow_ingress_on_worker_all" {
  for_each = {
    "Masters"         = aws_security_group.master.id,
    "MasterPrivateLB" = aws_security_group.master-private-lb.id
  }
  security_group_id        = aws_security_group.worker.id
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "all"
  source_security_group_id = each.value
  description              = "ALL: ${each.key} - Workers"
}

## Egress
resource "aws_security_group_rule" "egress_all" {
  for_each = {
    "BastionLB"       = aws_security_group.bastion-lb.id,
    "MasterPublicLB"  = aws_security_group.master-public-lb.id,
    "MasterPrivateLB" = aws_security_group.master-private-lb.id,
    "Bastion"         = aws_security_group.bastion.id,
    "Etcds"           = aws_security_group.etcd.id,
    "Masters"         = aws_security_group.master.id,
    "Workers"         = aws_security_group.worker.id
  }
  security_group_id = each.value
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Egress ALL: ${each.key}"
}