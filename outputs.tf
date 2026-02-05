#------------------------------------------------------------------------------
# AWS ECS SERVICE
#------------------------------------------------------------------------------
output "ecs_service" {
  description = "$${var.name_prefix} ECS Service - The ECS service object"
  value       = {
    id                     = aws_ecs_service.service.id
    name                   = aws_ecs_service.service.name
    cluster                = aws_ecs_service.service.cluster
    desired_count          = aws_ecs_service.service.desired_count
  }
}

#------------------------------------------------------------------------------
# AWS SECURITY GROUPS
#------------------------------------------------------------------------------
output "ecs_tasks_sg" {
  description = "$${var.name_prefix} ECS Tasks Security Group - The security group object"
  value       = {
    id          = aws_security_group.ecs_tasks_sg.id
    arn         = aws_security_group.ecs_tasks_sg.arn
    name        = aws_security_group.ecs_tasks_sg.name
    description = aws_security_group.ecs_tasks_sg.description
  }
}

#------------------------------------------------------------------------------
# APPLICATION LOAD BALANCER
#------------------------------------------------------------------------------
output "load_balancer" {
  description = "Load Balancer values"
  value       = var.use_custom_lb ? null : {
    id         = module.ecs-alb[0].aws_lb_lb_id
    arn        = module.ecs-alb[0].aws_lb_lb_arn
    arn_suffix = module.ecs-alb[0].aws_lb_lb_arn_suffix
    dns_name   = module.ecs-alb[0].aws_lb_lb_dns_name
    zone_id    = module.ecs-alb[0].aws_lb_lb_zone_id
  }
}

#------------------------------------------------------------------------------
# ACCESS CONTROL TO APPLICATION LOAD BALANCER
#------------------------------------------------------------------------------
output "load_balancer_security_group" {
  description = "Security Group values for Load Balancer access"
  value       = var.use_custom_lb ? null : {
    id          = module.ecs-alb[0].aws_security_group_lb_access_sg_id
    arn         = module.ecs-alb[0].aws_security_group_lb_access_sg_arn
    vpc_id      = module.ecs-alb[0].aws_security_group_lb_access_sg_vpc_id
    owner_id    = module.ecs-alb[0].aws_security_group_lb_access_sg_owner_id
    name        = module.ecs-alb[0].aws_security_group_lb_access_sg_name
    description = module.ecs-alb[0].aws_security_group_lb_access_sg_description
    ingress     = module.ecs-alb[0].aws_security_group_lb_access_sg_ingress
    egress      = module.ecs-alb[0].aws_security_group_lb_access_sg_egress
  }
}

#------------------------------------------------------------------------------
# AWS LOAD BALANCER - Target Groups
#------------------------------------------------------------------------------
output "lb_target_groups" {
  description = "Load Balancer Target Groups values"
  value       = var.use_custom_lb ? null : {
    http = {
      ids   = module.ecs-alb[0].lb_http_tgs_ids
      arns  = module.ecs-alb[0].lb_http_tgs_arns
      names = module.ecs-alb[0].lb_http_tgs_names
    }
    https = {
      ids   = module.ecs-alb[0].lb_https_tgs_ids
      arns  = module.ecs-alb[0].lb_https_tgs_arns
      names = module.ecs-alb[0].lb_https_tgs_names
    }
  }
}

#------------------------------------------------------------------------------
# AWS LOAD BALANCER - Listeners
#------------------------------------------------------------------------------
output "load_balancer_listeners" {
  description = "Load Balancer Listeners values"
  value       = var.use_custom_lb ? null : {
    http = {
      ids   = module.ecs-alb[0].lb_http_listeners_ids
      arns  = module.ecs-alb[0].lb_http_listeners_arns
    }
    https = {
      ids   = module.ecs-alb[0].lb_https_listeners_ids
      arns  = module.ecs-alb[0].lb_https_listeners_arns
    }
  }
}
