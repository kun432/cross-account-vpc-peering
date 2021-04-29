provider "aws" {
  region  = "ap-northeast-1"
}

module "vpc" {
  source = "../../modules/vpc"
  stage  = var.stage
  vpc_cidr  = var.vpc_cidr
}

module "security-groups" {
  source = "../../modules/security-groups"
  stage  = var.stage
  vpc_id = module.vpc.vpc_id
  vpc_cidr  = var.vpc_cidr
  other_vpc_cidr  = var.requester_vpc_cidr
}
module "ssm" {
  source = "../../modules/ssm"
  vpc_id = module.vpc.vpc_id
  sg_id = module.security-groups.sg_id
  private_subnet_ids = module.vpc.private_subnet_ids
}