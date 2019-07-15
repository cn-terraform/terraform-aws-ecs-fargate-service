# ---------------------------------------------------------------------------------------------------------------------
# AWS ECS SERVICE
# ---------------------------------------------------------------------------------------------------------------------
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

# ---------------------------------------------------------------------------------------------------------------------
# AWS LOAD BALANCER
# ---------------------------------------------------------------------------------------------------------------------
output "lb_id" {
  description = "$${var.name_preffix} Load Balancer ID"
  value       = aws_lb.lb.id
}

output "lb_arn" {
  description = "$${var.name_preffix} Load Balancer ARN"
  value       = aws_lb.lb.arn
}

output "lb_arn_suffix" {
  description = "$${var.name_preffix} Load Balancer ARN Suffix"
  value       = aws_lb.lb.arn_suffix
}

output "lb_dns_name" {
  description = "$${var.name_preffix} Load Balancer DNS Name"
  value       = aws_lb.lb.dns_name
}

output "lb_zone_id" {
  description = "$${var.name_preffix} Load Balancer Zone ID"
  value       = aws_lb.lb.zone_id
}

# ---------------------------------------------------------------------------------------------------------------------
# AWS SECURITY GROUPS
# ---------------------------------------------------------------------------------------------------------------------
output "lb_sg_id" {
  description = "$${var.name_preffix} Load Balancer Security Group - The ID of the security group"
  value       = aws_security_group.lb_sg.id
}

output "lb_sg_arn" {
  description = "$${var.name_preffix} Load Balancer Security Group - The ARN of the security group"
  value       = aws_security_group.lb_sg.arn
}

output "lb_sg_name" {
  description = "$${var.name_preffix} Load Balancer Security Group - The name of the security group"
  value       = aws_security_group.lb_sg.name
}

output "lb_sg_description" {
  description = "$${var.name_preffix} Load Balancer Security Group - The description of the security group"
  value       = aws_security_group.lb_sg.description
}

output "ecs_tasks_sg_id" {
  description = "$${var.name_preffix} ECS Tasks Security Group - The ID of the security group"
  value       = aws_security_group.ecs_tasks_sg.id
}

output "ecs_tasks_sg_arn" {
  description = "$${var.name_preffix} ECS Tasks Security Group - The ARN of the security group"
  value       = aws_security_group.ecs_tasks_sg.arn
}

output "ecs_tasks_sg_name" {
  description = "$${var.name_preffix} ECS Tasks Security Group - The name of the security group"
  value       = aws_security_group.ecs_tasks_sg.name
}

output "ecs_tasks_sg_description" {
  description = "$${var.name_preffix} ECS Tasks Security Group - The description of the security group"
  value       = aws_security_group.ecs_tasks_sg.description
}

