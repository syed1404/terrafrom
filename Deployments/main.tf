# VPC creation
module "vpc_test" {
  source = "./modules/vpc"
}

# subnet creation
module "vpc_subnet" {
  source = "./modules/subnet"
  vpc_id = module.vpc_test.vpc_id
}

#internet gateway
module "ig_gateway" {
  source = "./modules/internet gateway"
  vpc_id = module.vpc_test.vpc_id
}

#nat gateway
module "nat_gateway" {
  source = "./modules/nat gateway"
  public_subnet1 = var.public_subnet1 
}

