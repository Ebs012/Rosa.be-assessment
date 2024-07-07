variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "eu-west-2"
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_1_cidr_block" {
  description = "The CIDR block for the first subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "subnet_1_availability_zone" {
  description = "The availability zone for the first subnet"
  type        = string
  default     = "eu-west-2a"
}

variable "subnet_2_cidr_block" {
  description = "The CIDR block for the second subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "subnet_2_availability_zone" {
  description = "The availability zone for the second subnet"
  type        = string
  default     = "eu-west-2b"
}
