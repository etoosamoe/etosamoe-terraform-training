module "infra" {
  source = "./infra"
  vpc_id = var.vpc_id
  route_table_id = var.route_table_id
}