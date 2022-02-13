module "cluster" {
  source = "cn-terraform/ecs-cluster/aws"
  name   = "test-cluster"
}

module "base-network" {
  source                                      = "cn-terraform/networking/aws"
  name_prefix                                 = "test-networking"
  vpc_cidr_block                              = "192.168.0.0/16"
  availability_zones                          = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d"]
  public_subnets_cidrs_per_availability_zone  = ["192.168.0.0/19", "192.168.32.0/19", "192.168.64.0/19", "192.168.96.0/19"]
  private_subnets_cidrs_per_availability_zone = ["192.168.128.0/19", "192.168.160.0/19", "192.168.192.0/19", "192.168.224.0/19"]
}

module "td" {
  source          = "cn-terraform/ecs-fargate-task-definition/aws"
  name_prefix     = "test-td"
  container_image = "ubuntu"
  container_name  = "test"
}

module "service" {
  source              = "../../"
  name_prefix         = "test-service"
  vpc_id              = module.base-network.vpc_id
  ecs_cluster_arn     = module.cluster.aws_ecs_cluster_cluster_arn
  task_definition_arn = module.td.aws_ecs_task_definition_td_arn
  public_subnets      = module.base-network.public_subnets_ids
  private_subnets     = module.base-network.private_subnets_ids
  container_name      = "test"
  ecs_cluster_name    = module.cluster.aws_ecs_cluster_cluster_name
}
