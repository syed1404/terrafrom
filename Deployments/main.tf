# VPC creation
module "vpc_test" {
  source = "./modules/vpc"
}

# subnet creation
module "vpc_subnet" {
  source = "./modules/subnet"
  vpc_id = module.vpc_test.vpc_id
}
output "public_subnet1" {
  value = module.vpc_subnet.public_subnet1
}
output "public_subnet2" {
  value = module.vpc_subnet.public_subnet2
}
output "private_subnet1" {
  value = module.vpc_subnet.private_subnet1
}
output "private_subnet2" {
  value = module.vpc_subnet.private_subnet2
}
#internet gateway
module "ig_gateway" {
  source = "./modules/internet gateway"
  vpc_id = module.vpc_test.vpc_id
}

#nat gateway
module "nat_gateway" {
  source = "./modules/nat gateway"
  public_subnet1 = module.vpc_subnet.public_subnet1
}

#route table
module "route_table" {
  source = "./modules/route table"
  vpc_id = module.vpc_test.vpc_id
  nat_gateway = module.nat_gateway.nat_gateway
  ig_gateway = module.ig_gateway.ig_gateway
  public_subnet1 = module.vpc_subnet.public_subnet1
  public_subnet2 = module.vpc_subnet.public_subnet2
  private_subnet1 = module.vpc_subnet.private_subnet1
  private_subnet2 = module.vpc_subnet.private_subnet2
}

module "security_group" {
  source = "./modules/security group"
  vpc_id = module.vpc_test.vpc_id
}

module "ec2_web" {
  source = "./modules/ec2"
  instance_sg = module.security_group.instance_sg
  private_subnet1 = module.vpc_subnet.private_subnet1
}

