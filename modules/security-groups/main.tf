variable "stage" {}
variable "vpc_id" {}
variable "vpc_cidr" {}
variable "other_vpc_cidr" {}

resource "aws_security_group" "sg" {
  name = "${var.stage}-private-sg"
  vpc_id = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.stage}-private-sg"
  }
}

resource "aws_security_group_rule" "allow_all_from_same_vpc" {
  type                      = "ingress"
  from_port                 = 0
  to_port                   = 0
  protocol                  = "-1"
  security_group_id         = aws_security_group.sg.id
  cidr_blocks               = [var.vpc_cidr]
}

resource "aws_security_group_rule" "allow_icmp_from_other_vpc" {
  type                      = "ingress"
  from_port                 = 8
  to_port                   = 0
  protocol                  = "icmp"
  security_group_id         = aws_security_group.sg.id
  cidr_blocks               = [var.other_vpc_cidr]
}

output sg_id {
  value = aws_security_group.sg.id
}
