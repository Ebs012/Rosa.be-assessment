provider "aws" {
  region = var.aws_region
}

terraform {
  required_version = ">= 1.7.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

module "network" {
  source = "./modules/network"

  vpc_cidr_block           = var.vpc_cidr_block
  subnet_1_cidr_block      = var.subnet_1_cidr_block
  subnet_1_availability_zone = var.subnet_1_availability_zone
  subnet_2_cidr_block      = var.subnet_2_cidr_block
  subnet_2_availability_zone = var.subnet_2_availability_zone
}

module "ecs" {
  source = "./modules/ecs"

  vpc_id                  = module.network.vpc_id
  subnet_ids              = module.network.subnet_ids
  execution_role_arn      = module.iam.ecs_task_execution_role_arn
  security_group_ids      = [module.security_groups.ecs_tasks_sg_id]
}

module "load_balancer" {
  source = "./modules/load_balancer"

  vpc_id           = module.network.vpc_id
  subnet_ids       = module.network.subnet_ids
  security_group_id = module.security_groups.alb_sg_id
  target_group_arn = module.ecs.target_group_arn
}

module "iam" {
  source = "./modules/iam"
}

module "security_groups" {
  source = "./modules/security_groups"

  vpc_id = module.network.vpc_id
}
