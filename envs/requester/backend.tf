terraform {
  backend "s3" {
    bucket = "vpc-peering-requester"
    key    = "terraform.tfstate"
    region = "ap-northeast-1"
  }
}