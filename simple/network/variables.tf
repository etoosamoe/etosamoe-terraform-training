variable "aws_vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.23.0.0/16"
}

variable "project" {
  description = "Project name used for tags"
  type        = string
  default     = "k8s-etosamoe"
}

variable "owner" {
    default = "etosamoe"
}

### NETWORK

variable "availability_zones" {
    type        = number
    default = 1
}

variable "aws_region" {
  type        = string
  default     = "eu-central-1"
}