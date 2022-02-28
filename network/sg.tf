# SecurityGroups
resource "aws_security_group" "bastion-lb" {
  name_prefix = "bastion-lb-"
  description = "Bastion-LB"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name    = "${var.project}-bastion-lb"
    Project = var.project
    Owner   = var.owner
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "master-public-lb" {
  name_prefix = "master-public-lb-"
  description = "Master-Public-LB"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name    = "${var.project}-master-lb-public"
    Project = var.project
    Owner   = var.owner
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "master-private-lb" {
  name_prefix = "master-private-lb-"
  description = "Master-Private-LB"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name    = "${var.project}-master-lb-private"
    Project = var.project
    Owner   = var.owner
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "bastion" {
  name_prefix = "bastion-"
  description = "Bastion"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name    = "${var.project}-bastion"
    Project = var.project
    Owner   = var.owner
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "etcd" {
  name_prefix = "etcd-"
  description = "etcd"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name    = "${var.project}-etcd"
    Project = var.project
    Owner   = var.owner
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "master" {
  name_prefix = "k8s-master-"
  description = "K8s Master"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name    = "${var.project}-k8s-master"
    Project = var.project
    Owner   = var.owner
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "worker" {
  name_prefix = "k8s-worker-"
  description = "K8s Worker"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name    = "${var.project}-k8s-worker"
    Project = var.project
    Owner   = var.owner
  }

  lifecycle {
    create_before_destroy = true
  }
}