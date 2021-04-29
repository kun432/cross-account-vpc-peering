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
  other_vpc_cidr  = var.accepter_vpc_cidr
}

module "ssm" {
  source = "../../modules/ssm"
  vpc_id = module.vpc.vpc_id
  sg_id = module.security-groups.sg_id
  private_subnet_ids = module.vpc.private_subnet_ids
}

resource "aws_vpc_peering_connection" "peer" {
  peer_owner_id = var.accepter_account
  peer_vpc_id   = var.accepter_vpc_id
  vpc_id        = module.vpc.vpc_id

  tags = {
    Name = "vpc-peering-to-accepter"
  }
}

resource "aws_route" "route_vpc_peering" {
  route_table_id            = module.vpc.private_route_table_id
  destination_cidr_block    = var.accepter_vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
  depends_on                = [aws_vpc_peering_connection.peer]
}