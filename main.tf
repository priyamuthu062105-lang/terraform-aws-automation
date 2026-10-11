module "networking" {
  source = "./modules/networking"

  vpc_cidr            = var.vpc_cidr
  public_subnet_cidrs = var.public_subnet_cidrs
  environment         = var.environment
}

module "compute" {
  source = "./modules/compute"

  ami_id            = var.ami_id
  instance_type     = var.instance_type
  subnet_id         = module.networking.public_subnet_ids[0]
  security_group_id = module.networking.security_group_id
  environment       = var.environment
}
