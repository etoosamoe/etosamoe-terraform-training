resource "aws_instance" "bastion" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = aws_key_pair.etosamoe.id
  subnet_id              = aws_subnet.public[0].id
  vpc_security_group_ids = [aws_security_group.bastion.id]
  tags = {
    Name = "${var.project}-bastion"
  }
}

resource "aws_instance" "node" {
  count                  = var.instance_count
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = aws_key_pair.etosamoe.id
  subnet_id              = aws_subnet.private[0].id
  vpc_security_group_ids = [aws_security_group.private.id]
  tags = {
    Name = "${var.project}-node${count.index}"
  }
}
