#------------------------------------------------------------------------------
# AWS ECS SERVICE
#------------------------------------------------------------------------------
output "aws_ecs_service_service_id" {
  description = "The Amazon Resource Name (ARN) that identifies the service."
  value       = aws_ecs_service.service.id
}

output "aws_ecs_service_service_name" {
  description = "The name of the service."
  value       = aws_ecs_service.service.name
}

output "aws_ecs_service_service_cluster" {
  description = "The Amazon Resource Name (ARN) of cluster which the service runs on."
  value       = aws_ecs_service.service.cluster
}

output "aws_ecs_service_service_desired_count" {
  description = "The number of instances of the task definition"
  value       = aws_ecs_service.service.desired_count
}

#------------------------------------------------------------------------------
# AWS SECURITY GROUPS
#------------------------------------------------------------------------------
output "ecs_tasks_sg_id" {
  description = "$${var.name_prefix} ECS Tasks Security Group - The ID of the security group"
  value       = aws_security_group.ecs_tasks_sg.id
}

output "ecs_tasks_sg_arn" {
  description = "$${var.name_prefix} ECS Tasks Security Group - The ARN of the security group"
  value       = aws_security_group.ecs_tasks_sg.arn
}

output "ecs_tasks_sg_name" {
  description = "$${var.name_prefix} ECS Tasks Security Group - The name of the security group"
  value       = aws_security_group.ecs_tasks_sg.name
}

output "ecs_tasks_sg_description" {
  description = "$${var.name_prefix} ECS Tasks Security Group - The description of the security group"
  value       = aws_security_group.ecs_tasks_sg.description
}

#------------------------------------------------------------------------------
# APPLICATION LOAD BALANCER
#------------------------------------------------------------------------------
output "aws_lb_lb_id" {
  description = "The ARN of the load balancer (matches arn)."
  value       = module.ecs-alb.aws_lb_lb_id
}

output "aws_lb_lb_arn" {
  description = "The ARN of the load balancer (matches id)."
  value       = module.ecs-alb.aws_lb_lb_arn
}

output "aws_lb_lb_arn_suffix" {
  description = "The ARN suffix for use with CloudWatch Metrics."
  value       = module.ecs-alb.aws_lb_lb_arn_suffix
}

output "aws_lb_lb_dns_name" {
  description = "The DNS name of the load balancer."
  value       = module.ecs-alb.aws_lb_lb_dns_name
}

output "aws_lb_lb_zone_id" {
  description = "The canonical hosted zone ID of the load balancer (to be used in a Route 53 Alias record)."
  value       = module.ecs-alb.aws_lb_lb_zone_id
}

#------------------------------------------------------------------------------
# ACCESS CONTROL TO APPLICATION LOAD BALANCER
#------------------------------------------------------------------------------
output "aws_security_group_lb_access_sg_id" {
  description = "The ID of the security group"
  value       = module.ecs-alb.aws_security_group_lb_access_sg_id
}

output "aws_security_group_lb_access_sg_arn" {
  description = "The ARN of the security group"
  value       = module.ecs-alb.aws_security_group_lb_access_sg_arn
}

output "aws_security_group_lb_access_sg_vpc_id" {
  description = "The VPC ID."
  value       = module.ecs-alb.aws_security_group_lb_access_sg_vpc_id
}

output "aws_security_group_lb_access_sg_owner_id" {
  description = "The owner ID."
  value       = module.ecs-alb.aws_security_group_lb_access_sg_owner_id
}

output "aws_security_group_lb_access_sg_name" {
  description = "The name of the security group"
  value       = module.ecs-alb.aws_security_group_lb_access_sg_name
}

output "aws_security_group_lb_access_sg_description" {
  description = "The description of the security group"
  value       = module.ecs-alb.aws_security_group_lb_access_sg_description
}

output "aws_security_group_lb_access_sg_ingress" {
  description = "The ingress rules."
  value       = module.ecs-alb.aws_security_group_lb_access_sg_ingress
}

output "aws_security_group_lb_access_sg_egress" {
  description = "The egress rules."
  value       = module.ecs-alb.aws_security_group_lb_access_sg_egress
}

#------------------------------------------------------------------------------
# AWS LOAD BALANCER - Target Groups
#------------------------------------------------------------------------------
output "lb_http_tgs_ids" {
  description = "List of HTTP Target Groups IDs"
  value       = module.ecs-alb.lb_http_tgs_ids
}

output "lb_http_tgs_arns" {
  description = "List of HTTP Target Groups ARNs"
  value       = module.ecs-alb.lb_http_tgs_arns
}

output "lb_http_tgs_names" {
  description = "List of HTTP Target Groups Names"
  value       = module.ecs-alb.lb_http_tgs_names
}

output "lb_https_tgs_ids" {
  description = "List of HTTPS Target Groups IDs"
  value       = module.ecs-alb.lb_https_tgs_ids
}

output "lb_https_tgs_arns" {
  description = "List of HTTPS Target Groups ARNs"
  value       = module.ecs-alb.lb_https_tgs_arns
}

output "lb_https_tgs_names" {
  description = "List of HTTPS Target Groups Names"
  value       = module.ecs-alb.lb_https_tgs_names
}

#------------------------------------------------------------------------------
# AWS LOAD BALANCER - Listeners
#------------------------------------------------------------------------------
output "lb_http_listeners_ids" {
  description = "List of HTTP Listeners IDs"
  value       = module.ecs-alb.lb_http_listeners_ids
}

output "lb_http_listeners_arns" {
  description = "List of HTTP Listeners ARNs"
  value       = module.ecs-alb.lb_http_listeners_arns
}

output "lb_https_listeners_ids" {
  description = "List of HTTPS Listeners IDs"
  value       = module.ecs-alb.lb_https_listeners_ids
}

output "lb_https_listeners_arns" {
  description = "List of HTTPS Listeners ARNs"
  value       = module.ecs-alb.lb_https_listeners_arns
}
