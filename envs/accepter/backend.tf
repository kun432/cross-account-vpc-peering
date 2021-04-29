terraform {
  backend "s3" {
    bucket = "vpc-peering-accepter"
    key    = "terraform.tfstate"
    region = "ap-northeast-1"
  }
}