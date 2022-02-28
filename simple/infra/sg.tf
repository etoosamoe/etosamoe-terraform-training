resource "aws_security_group" "bastion" {
  vpc_id      = var.vpc_id

  ingress {
    protocol  = "tcp"
    from_port = 22
    to_port   = 22

    cidr_blocks = [var.admin_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "bastion-sg"
  }
}

resource "aws_security_group" "k8s" {
  vpc_id      = var.vpc_id

  ingress {
    protocol  = "tcp"
    from_port = 0
    to_port   = 0

    cidr_blocks = [aws_subnet.public[0].cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "k8s-sg"
  }
}