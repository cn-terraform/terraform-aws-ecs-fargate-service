#------------------------------------------------------------------------------
# AWS LOAD BALANCER
#------------------------------------------------------------------------------

data "aws_lb" "lb" {
  arn = var.lb_arn
}

data "aws_lb_target_group" "lb_http_target_groups" {
  for_each = toset(var.lb_http_tgs_arns)
  arn   = element(var.lb_http_tgs_arns, each.key)
}

data "aws_lb_target_group" "lb_https_target_groups" {
  for_each = toset(var.lb_https_tgs_arns)
  arn   = element(var.lb_https_tgs_arns, each.key)
}

data "aws_lb_listener" "lb_http_listeners" {
  for_each = toset(var.lb_http_listeners_arns)
  arn   = element(var.lb_http_listeners_arns, each.key)
}

data "aws_lb_listener" "lb_https_listeners" {
  for_each = toset(var.lb_https_listeners_arns)
  arn   = element(var.lb_https_listeners_arns, each.key)
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
  health_check_grace_period_seconds  = var.health_check_grace_period_seconds
  launch_type                        = "FARGATE"
  force_new_deployment               = var.force_new_deployment
  dynamic "load_balancer" {
    for_each = data.aws_lb_target_group.lb_http_target_groups
    content {
      target_group_arn = load_balancer.value.arn
      container_name   = var.container_name
      container_port   = load_balancer.value.port
    }
  }
  dynamic "load_balancer" {
    for_each = data.aws_lb_target_group.lb_https_target_groups
    content {
      target_group_arn = load_balancer.value.arn
      container_name   = var.container_name
      container_port   = load_balancer.value.port
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
  tags = {
    Name = "${var.name_prefix}-ecs-tasks-sg"
  }
}

#------------------------------------------------------------------------------
# AWS SECURITY GROUP - ECS Tasks, allow traffic only from Load Balancer
#------------------------------------------------------------------------------
resource "aws_security_group" "ecs_tasks_sg" {
  name        = "${var.name_prefix}-ecs-tasks-sg"
  description = "Allow inbound access from the LB only"
  vpc_id      = var.vpc_id
  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.name_prefix}-ecs-tasks-sg"
  }
}

resource "aws_security_group_rule" "ingress_through_http" {
  count                    = length(data.aws_lb_target_group.lb_http_target_groups)
  security_group_id        = aws_security_group.ecs_tasks_sg.id
  type                     = "ingress"
  from_port                = element(data.aws_lb_target_group.lb_http_target_groups.*.port, count.index)
  to_port                  = element(data.aws_lb_target_group.lb_http_target_groups.*.port, count.index)
  protocol                 = "tcp"
  source_security_group_id = var.load_balancer_sg_id
}

resource "aws_security_group_rule" "ingress_through_https" {
  count                    = length(data.aws_lb_target_group.lb_https_target_groups)
  security_group_id        = aws_security_group.ecs_tasks_sg.id
  type                     = "ingress"
  from_port                = element(data.aws_lb_target_group.lb_https_target_groups.*.port, count.index)
  to_port                  = element(data.aws_lb_target_group.lb_https_target_groups.*.port, count.index)
  protocol                 = "tcp"
  source_security_group_id = var.load_balancer_sg_id
}
