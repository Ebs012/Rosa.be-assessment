output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.network.vpc_id
}

output "subnet_ids" {
  description = "The IDs of the subnets"
  value       = module.network.subnet_ids
}

output "ecs_cluster_id" {
  description = "The ID of the ECS cluster"
  value       = module.ecs.cluster_id
}

output "ecs_service_id" {
  description = "The ID of the ECS service"
  value       = module.ecs.service_id
}

output "load_balancer_dns" {
  description = "The DNS name of the load balancer"
  value       = module.load_balancer.dns_name
}
