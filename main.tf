#------------------------------------------------------------------------------
# AWS LOAD BALANCER
#------------------------------------------------------------------------------
module "ecs-alb" {
  source  = "cn-terraform/ecs-alb/aws"
  version = "1.0.16"

  name_prefix = var.name_prefix
  vpc_id      = var.vpc_id

  # S3 Bucket
  block_s3_bucket_public_access = var.block_s3_bucket_public_access

  # Application Load Balancer
  internal                         = var.lb_internal
  security_groups                  = var.lb_security_groups
  drop_invalid_header_fields       = var.lb_drop_invalid_header_fields
  private_subnets                  = var.private_subnets
  public_subnets                   = var.public_subnets
  idle_timeout                     = var.lb_idle_timeout
  enable_deletion_protection       = var.lb_enable_deletion_protection
  enable_cross_zone_load_balancing = var.lb_enable_cross_zone_load_balancing
  enable_http2                     = var.lb_enable_http2
  ip_address_type                  = var.lb_ip_address_type

  # Access Control to Application Load Balancer
  http_ports                    = var.lb_http_ports
  http_ingress_cidr_blocks      = var.lb_http_ingress_cidr_blocks
  http_ingress_prefix_list_ids  = var.lb_http_ingress_prefix_list_ids
  https_ports                   = var.lb_https_ports
  https_ingress_cidr_blocks     = var.lb_https_ingress_cidr_blocks
  https_ingress_prefix_list_ids = var.lb_https_ingress_prefix_list_ids

  # Target Groups
  deregistration_delay                          = var.lb_deregistration_delay
  slow_start                                    = var.lb_slow_start
  load_balancing_algorithm_type                 = var.lb_load_balancing_algorithm_type
  stickiness                                    = var.lb_stickiness
  target_group_health_check_enabled             = var.lb_target_group_health_check_enabled
  target_group_health_check_interval            = var.lb_target_group_health_check_interval
  target_group_health_check_path                = var.lb_target_group_health_check_path
  target_group_health_check_timeout             = var.lb_target_group_health_check_timeout
  target_group_health_check_healthy_threshold   = var.lb_target_group_health_check_healthy_threshold
  target_group_health_check_unhealthy_threshold = var.lb_target_group_health_check_unhealthy_threshold
  target_group_health_check_matcher             = var.lb_target_group_health_check_matcher

  # Certificates
  default_certificate_arn                         = var.default_certificate_arn
  ssl_policy                                      = var.ssl_policy
  additional_certificates_arn_for_https_listeners = var.additional_certificates_arn_for_https_listeners

  # Optional tags
  tags = var.tags
}

#------------------------------------------------------------------------------
# AWS ECS SERVICE
#------------------------------------------------------------------------------
resource "aws_ecs_service" "service" {
  name = "${var.name_prefix}-service"
  # capacity_provider_strategy - (Optional) The capacity provider strategy to use for the service. Can be one or more. Defined below.
  cluster                            = var.ecs_cluster_arn
  deployment_maximum_percent         = var.deployment_maximum_percent
  deployment_minimum_healthy_percent = var.deployment_minimum_healthy_percent
  desired_count                      = var.desired_count
  enable_ecs_managed_tags            = var.enable_ecs_managed_tags
  enable_execute_command             = var.enable_execute_command
  health_check_grace_period_seconds  = var.health_check_grace_period_seconds
  launch_type                        = "FARGATE"
  force_new_deployment               = var.force_new_deployment

  dynamic "load_balancer" {
    for_each = module.ecs-alb.lb_http_tgs_map_arn_port
    content {
      target_group_arn = load_balancer.key
      container_name   = var.container_name
      container_port   = load_balancer.value
    }
  }
  dynamic "load_balancer" {
    for_each = module.ecs-alb.lb_https_tgs_map_arn_port
    content {
      target_group_arn = load_balancer.key
      container_name   = var.container_name
      container_port   = load_balancer.value
    }
  }
  network_configuration {
    security_groups  = concat([aws_security_group.ecs_tasks_sg.id], var.security_groups)
    subnets          = var.assign_public_ip ? var.public_subnets : var.private_subnets
    assign_public_ip = var.assign_public_ip
  }
  dynamic "ordered_placement_strategy" {
    for_each = var.ordered_placement_strategy
    content {
      type  = ordered_placement_strategy.value.type
      field = lookup(ordered_placement_strategy.value, "field", null)
    }
  }
  dynamic "deployment_controller" {
    for_each = var.deployment_controller
    content {
      type = deployment_controller.value.type
    }
  }
  dynamic "placement_constraints" {
    for_each = var.placement_constraints
    content {
      expression = lookup(placement_constraints.value, "expression", null)
      type       = placement_constraints.value.type
    }
  }
  platform_version = var.platform_version
  propagate_tags   = var.propagate_tags
  dynamic "service_registries" {
    for_each = var.service_registries
    content {
      registry_arn   = service_registries.value.registry_arn
      port           = lookup(service_registries.value, "port", null)
      container_name = lookup(service_registries.value, "container_name", null)
      container_port = lookup(service_registries.value, "container_port", null)
    }
  }
  task_definition = var.task_definition_arn
  tags = merge(
    var.tags,
    {
      Name = "${var.name_prefix}-ecs-tasks-sg"
    },
  )
}

#------------------------------------------------------------------------------
# AWS SECURITY GROUP - ECS Tasks, allow traffic only from Load Balancer
#------------------------------------------------------------------------------
resource "aws_security_group" "ecs_tasks_sg" {
  name        = "${var.name_prefix}-ecs-tasks-sg"
  description = "Allow inbound access from the LB only"
  vpc_id      = var.vpc_id

  tags = merge(
    var.tags,
    {
      Name = "${var.name_prefix}-ecs-tasks-sg"
    },
  )
}

resource "aws_security_group_rule" "egress" {
  count             = var.ecs_tasks_sg_allow_egress_to_anywhere ? 1 : 0
  security_group_id = aws_security_group.ecs_tasks_sg.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ingress_through_http" {
  for_each                 = toset(module.ecs-alb.lb_http_tgs_ports)
  security_group_id        = aws_security_group.ecs_tasks_sg.id
  type                     = "ingress"
  from_port                = each.key
  to_port                  = each.key
  protocol                 = "tcp"
  source_security_group_id = module.ecs-alb.aws_security_group_lb_access_sg_id
}

resource "aws_security_group_rule" "ingress_through_https" {
  for_each                 = toset(module.ecs-alb.lb_https_tgs_ports)
  security_group_id        = aws_security_group.ecs_tasks_sg.id
  type                     = "ingress"
  from_port                = each.key
  to_port                  = each.key
  protocol                 = "tcp"
  source_security_group_id = module.ecs-alb.aws_security_group_lb_access_sg_id
}

module "ecs-autoscaling" {
  count = var.enable_autoscaling ? 1 : 0

  source  = "cn-terraform/ecs-service-autoscaling/aws"
  version = "1.0.6"

  name_prefix               = var.name_prefix
  ecs_cluster_name          = var.ecs_cluster_name
  ecs_service_name          = aws_ecs_service.service.name
  max_cpu_threshold         = var.max_cpu_threshold
  min_cpu_threshold         = var.min_cpu_threshold
  max_cpu_evaluation_period = var.max_cpu_evaluation_period
  min_cpu_evaluation_period = var.min_cpu_evaluation_period
  max_cpu_period            = var.max_cpu_period
  min_cpu_period            = var.min_cpu_period
  scale_target_max_capacity = var.scale_target_max_capacity
  scale_target_min_capacity = var.scale_target_min_capacity
  tags                      = var.tags
}
