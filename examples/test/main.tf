provider "aws" {
  region = "us-east-1"
}

module "cluster" {
  source  = "cn-terraform/ecs-cluster/aws"
  version = "1.0.5"
  name    = "test-cluster"
}

module "base-network" {
  source                                      = "cn-terraform/networking/aws"
  version                                     = "2.0.7"
  name_preffix                                = "test-networking"
  vpc_cidr_block                              = "192.168.0.0/16"
  availability_zones                          = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d"]
  public_subnets_cidrs_per_availability_zone  = ["192.168.0.0/19", "192.168.32.0/19", "192.168.64.0/19", "192.168.96.0/19"]
  private_subnets_cidrs_per_availability_zone = ["192.168.128.0/19", "192.168.160.0/19", "192.168.192.0/19", "192.168.224.0/19"]
}

module "load_balancer" {
  source          = "cn-terraform/ecs-alb/aws"
  version         = "1.0.2"
  name_preffix    = "test-alb"
  vpc_id          = module.base-network.vpc_id
  private_subnets = module.base-network.private_subnets_ids
  public_subnets  = module.base-network.public_subnets_ids
}

module "td" {
  source          = "cn-terraform/ecs-fargate-task-definition/aws"
  version         = "1.0.11"
  name_preffix    = "test-td"
  container_image = "ubuntu"
  container_name  = "test"
}

module "service" {
  source                  = "../../"
  name_preffix            = "test-service"
  vpc_id                  = module.base-network.vpc_id
  ecs_cluster_arn         = module.cluster.aws_ecs_cluster_cluster_arn
  task_definition_arn     = module.td.aws_ecs_task_definition_td_arn
  public_subnets          = module.base-network.public_subnets_ids
  private_subnets         = module.base-network.private_subnets_ids
  container_name          = "test"
  ecs_cluster_name        = module.cluster.aws_ecs_cluster_cluster_name
  lb_arn                  = module.load_balancer.aws_lb_lb_arn
  lb_http_tgs_arns        = module.load_balancer.lb_http_tgs_arns
  lb_https_tgs_arns       = module.load_balancer.lb_https_tgs_arns
  lb_http_listeners_arns  = module.load_balancer.lb_http_listeners_arns
  lb_https_listeners_arns = module.load_balancer.lb_https_listeners_arns
  load_balancer_sg_id     = module.load_balancer.aws_security_group_lb_access_sg_id
}
