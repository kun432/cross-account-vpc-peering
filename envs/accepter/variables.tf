variable "stage" {
  default = "accepter"
}

variable "vpc_cidr" {
  default = "192.168.0.0/16"
}

variable "requester_vpc_cidr" {
  default = "10.0.0.0/16"
}