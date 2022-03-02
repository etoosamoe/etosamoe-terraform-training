resource "aws_instance" "bastion" {
  ami                    = var.bastion_ami
  instance_type          = var.instance_type
  key_name               = aws_key_pair.etosamoe.id
  subnet_id              = aws_subnet.public[0].id
  vpc_security_group_ids = [aws_security_group.bastion.id]
  tags = {
    Name = "k8s-bastion"
  }
}

resource "aws_instance" "k8s-master" {
  ami                    = var.k8s_ami
  instance_type          = var.instance_type
  key_name               = aws_key_pair.etosamoe.id
  subnet_id              = aws_subnet.private[0].id
  vpc_security_group_ids = [aws_security_group.k8s.id]
  tags = {
    Name = "k8s-master"
  }
}

resource "aws_instance" "k8s-worker" {
  ami                    = var.k8s_ami
  instance_type          = var.instance_type
  key_name               = aws_key_pair.etosamoe.id
  subnet_id              = aws_subnet.private[0].id
  vpc_security_group_ids = [aws_security_group.k8s.id]
  tags = {
    Name = "k8s-worker"
  }
}
