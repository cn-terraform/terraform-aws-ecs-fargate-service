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

