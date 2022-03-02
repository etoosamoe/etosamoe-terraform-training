variable "ami" {
  default = "ami-0d527b8c289b4af7f"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "instance_count" {
  description = "Elasticsearch instances count"
  default     = "3"
}

variable "vpc_id" {

}
variable "route_table_id" {

}

variable "aws_vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "172.31.0.0/16"
}

variable "admin_cidr" {
  description = "CIDR pattern to access the bastion host"
  type        = string
  default     = "0.0.0.0/0"
}

variable "project" {
  description = "Project name used for tags"
  type        = string
  default     = "es"
}

variable "owner" {
  default = "etosamoe"
}

### NETWORK

variable "availability_zones" {
  type    = number
  default = "1"
}

variable "aws_region" {
  type    = string
  default = "eu-central-1"
}