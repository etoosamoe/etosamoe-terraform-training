resource "aws_instance" "bastion" {
  ami                    = var.bastion_ami
  instance_type          = var.instance_type
  key_name               = var.aws_key_pair_name
  vpc_security_group_ids = ["aws_security_group.bastion.name"]
  tags = {
    Name = "k8s-bastion"
  }
}
