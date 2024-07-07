resource "aws_vpc" "app_vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "app_vpc"
  }
}

resource "aws_subnet" "app_subnet" {
  count                  = 2
  vpc_id                 = aws_vpc.app_vpc.id
  cidr_block             = element([var.subnet_1_cidr_block, var.subnet_2_cidr_block], count.index)
  availability_zone      = element([var.subnet_1_availability_zone, var.subnet_2_availability_zone], count.index)
  map_public_ip_on_launch = true
}

output "vpc_id" {
  value = aws_vpc.app_vpc.id
}

output "subnet_ids" {
  value = aws_subnet.app_subnet[*].id
}
