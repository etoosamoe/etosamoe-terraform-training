# AWS VPC
resource "aws_vpc" "main" {
  cidr_block                       = var.aws_vpc_cidr
  enable_dns_hostnames             = true
  assign_generated_ipv6_cidr_block = false

  tags = {
    Name    = "${var.project}-vpc"
    Project = var.project
    Owner   = var.owner
  }
}

# Public Subnets
resource "aws_subnet" "public" {
  count             = var.availability_zones
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.aws_vpc_cidr, 8, count.index + 11)
  tags = {
    Name      = "${var.project}-public-${count.index}"
    Attribute = "public"
    Project   = var.project
    Owner     = var.owner
  }
}

# Private Subnets
resource "aws_subnet" "private" {
  count                   = var.availability_zones
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.aws_vpc_cidr, 8, count.index + 1)
  map_public_ip_on_launch = false

  tags = {
    Name      = "${var.project}-private-${count.index}"
    Attribute = "private"
    Project   = var.project
    Owner     = var.owner
  }
}