variable "bastion_ami" {
  default = "ami-0d527b8c289b4af7f"
}

variable "k8s_ami" {
  default = "ami-0d527b8c289b4af7f"
}

variable "instance_type" {
    default = "t2.micro"
}

variable "aws_key_pair_name" {
  description = "AWS Key Pair name to use for EC2 Instances (if already existent)"
  type        = string
  default     = "key-06850f2ed3d720a42"
}