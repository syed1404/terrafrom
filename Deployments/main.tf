# VPC creation
module "vpc_test" {
  source = "./modules/vpc"
}


# subnet creation
module "vpc_subnet" {
  source = "./modules/subnet"
  vpc_id = module.vpc_test.vpc_id
}


