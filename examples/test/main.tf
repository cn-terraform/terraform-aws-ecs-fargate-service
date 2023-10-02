locals {
  public_subnet_ids  = [for s in module.base-network.public_subnets : s.id]
  private_subnet_ids = [for s in module.base-network.private_subnets : s.id]
}

module "cluster" {
  source = "cn-terraform/ecs-cluster/aws"
  name   = "test-cluster"
}

module "base-network" {
  source = "cn-terraform/networking/aws"

  cidr_block = "192.168.0.0/16"

  vpc_additional_tags = {
    vpc_tag1 = "tag1",
    vpc_tag2 = "tag2",
  }

  public_subnets = {
    first_public_subnet = {
      availability_zone = "us-east-1a"
      cidr_block        = "192.168.0.0/19"
    }
    second_public_subnet = {
      availability_zone = "us-east-1b"
      cidr_block        = "192.168.32.0/19"
    }
  }

  public_subnets_additional_tags = {
    public_subnet_tag1 = "tag1",
    public_subnet_tag2 = "tag2",
  }

  private_subnets = {
    first_private_subnet = {
      availability_zone = "us-east-1a"
      cidr_block        = "192.168.128.0/19"
    }
    second_private_subnet = {
      availability_zone = "us-east-1b"
      cidr_block        = "192.168.160.0/19"
    }
  }

  private_subnets_additional_tags = {
    private_subnet_tag1 = "tag1",
    private_subnet_tag2 = "tag2",
  }
}

module "td" {
  source          = "cn-terraform/ecs-fargate-task-definition/aws"
  name_prefix     = "test-td"
  container_image = "ubuntu"
  container_name  = "test"
}

module "service" {
  source              = "../../"
  name_prefix         = "test"
  vpc_id              = module.base-network.vpc_id
  ecs_cluster_arn     = module.cluster.aws_ecs_cluster_cluster_arn
  task_definition_arn = module.td.aws_ecs_task_definition_td_arn
  public_subnets      = local.public_subnet_ids
  private_subnets     = local.private_subnet_ids
  container_name      = "test"
  ecs_cluster_name    = module.cluster.aws_ecs_cluster_cluster_name
}
