
# Public Subnets
resource "aws_subnet" "public" {
  count             = var.availability_zones
  vpc_id            = var.vpc_id
  cidr_block        = cidrsubnet(var.aws_vpc_cidr, 8, count.index + 11)
  map_public_ip_on_launch = true
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
  vpc_id                  = var.vpc_id
  cidr_block              = cidrsubnet(var.aws_vpc_cidr, 8, count.index + 1)
  map_public_ip_on_launch = false

  tags = {
    Name      = "${var.project}-private-${count.index}"
    Attribute = "private"
    Project   = var.project
    Owner     = var.owner
  }
}