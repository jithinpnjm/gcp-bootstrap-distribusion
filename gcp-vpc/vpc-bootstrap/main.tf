module "vpc" {
  source                              = "../modules/vpc"
  project_id                          = var.project_id
  vpc_name                            = var.vpc_name
  vpc_auto_create_subnetworks         = var.vpc_auto_create_subnetworks
  vpc_delete_default_routes_on_create = var.vpc_delete_default_routes_on_create
  vpc_routing_mode                    = var.vpc_routing_mode
}

module "subnet" {
  source                = "../modules/subnets"
  subnet_attributes     = var.subnet_attributes
  subnet_vpc_name       = module.vpc.self_link
  project_id            = var.project_id
}

module "firewall" {
  source = "../modules/firewall"
  firewall_attributes = var.firewall_attributes
  firewall_vpc_name   = module.vpc.self_link
  project_id          = var.project_id
}

module "cloud_router" {
  source = "../modules/cloud_router"
  project_id              = var.project_id
  cloud_router_attributes = var.cloud_router_attributes
  cloud_router_vpc_name   = module.vpc.self_link
}
module "nat" {
  depends_on = [module.cloud_router]
  source = "../modules/nat"
  project_id              = var.project_id
  gcp_nat_attributes = var.gcp_nat_attributes
  
}