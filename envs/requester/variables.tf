variable "stage" {
  default = "requester"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "accepter_vpc_cidr" {
  default = "192.168.0.0/16"
}

variable "accepter_account" {
  default = "123456789012"
}

variable "accepter_vpc_id" {
  default = "vpc-12345678901234567"
}