# AWS ECS Fargate Terraform Module #

This Terraform module deploys an AWS ECS Fargate service.

[![CircleCI](https://circleci.com/gh/jnonino/terraform-aws-ecs-fargate-service/tree/master.svg?style=svg)](https://circleci.com/gh/jnonino/terraform-aws-ecs-fargate-service/tree/master)
[![](https://img.shields.io/github/license/jnonino/terraform-aws-ecs-fargate-service)](https://github.com/jnonino/terraform-aws-ecs-fargate-service)
[![](https://img.shields.io/github/issues/jnonino/terraform-aws-ecs-fargate-service)](https://github.com/jnonino/terraform-aws-ecs-fargate-service)
[![](https://img.shields.io/github/issues-closed/jnonino/terraform-aws-ecs-fargate-service)](https://github.com/jnonino/terraform-aws-ecs-fargate-service)
[![](https://img.shields.io/github/languages/code-size/jnonino/terraform-aws-ecs-fargate-service)](https://github.com/jnonino/terraform-aws-ecs-fargate-service)
[![](https://img.shields.io/github/repo-size/jnonino/terraform-aws-ecs-fargate-service)](https://github.com/jnonino/terraform-aws-ecs-fargate-service)

## Usage

Check valid versions on:
* Github Releases: <https://github.com/jnonino/terraform-aws-ecs-fargate-service/releases>
* Terraform Module Registry: <https://registry.terraform.io/modules/jnonino/ecs-fargate-service/aws>

        module "ecs-fargate-service" {
            source              = "jnonino/ecs-fargate-service/aws"
            version             = "1.0.2"
            name_preffix        = var.name_preffix
            profile             = var.profile
            region              = var.region
            vpc_id              = module.networking.vpc_id
            task_definition_arn = module.td.aws_ecs_task_definition_td_arn
            container_port      = module.td.container_port
            ecs_cluster_name    = module.ecs-cluster.aws_ecs_cluster_cluster_name
            ecs_cluster_arn     = module.ecs-cluster.aws_ecs_cluster_cluster_arn
            subnets             = module.networking.private_subnets_ids
        }

Check the section "Other modules that you may need to use this module" for details about modules mentioned in the usage example.

## Input values

* name_preffix: Name preffix for resources on AWS.
* profile: AWS API key credentials to use.
* region: AWS Region the infrastructure is hosted in.
* vpc_id: ID of the VPC.
* task_definition_arn: (Required) The full ARN of the task definition that you want to run in your service.
* ecs_cluster_name = Name of the ECS cluster.
* ecs_cluster_arn: ARN of an ECS cluster.
* subnets: The subnets associated with the task or service.
* container_name: Name of the running container.
* container_port: Port on which the container is listening.
* desired_count: (Optional) The number of instances of the task definition to place and keep running. Defaults to 1.
* platform_version: (Optional) The platform version on which to run your service. Defaults to LATEST. More information about Fargate platform versions can be found in the AWS ECS User Guide.
* deployment_maximum_percent: (Optional) The upper limit (as a percentage of the service's desiredCount) of the number of running tasks that can be running in a service during a deployment.
* deployment_minimum_healthy_percent: (Optional) The lower limit (as a percentage of the service's desiredCount) of the number of running tasks that must remain running and healthy in a service during a deployment.
* enable_ecs_managed_tags: (Optional) Specifies whether to enable Amazon ECS managed tags for the tasks within the service.
* propagate_tags: (Optional) Specifies whether to propagate the tags from the task definition or the service to the tasks. The valid values are SERVICE and TASK_DEFINITION. Default to SERVICE.
* ordered_placement_strategy: (Optional) Service level strategy rules that are taken into consideration during task placement. List from top to bottom in order of precedence. The maximum number of ordered_placement_strategy blocks is 5. This is a list of maps where each map should contain "id" and "field".
* health_check_grace_period_seconds: (Optional) Seconds to ignore failing load balancer health checks on newly instantiated tasks to prevent premature shutdown, up to 2147483647. Only valid for services configured to use load balancers.
* health_check_path: (Optional) The destination for the health check request.
* placement_constraints: (Optional) rules that are taken into consideration during task placement. Maximum number of placement_constraints is 10. This is a list of maps, where each map should contain "type" and "expression".
* service_registries: (Optional) The service discovery registries for the service. The maximum number of service_registries blocks is 1. This is a map that should contain the following fields "registry_arn", "port", "container_port" and "container_name".
* security_groups: (Optional) The security groups associated with the task or service. If you do not specify a security group, the default security group for the VPC is used.
* assign_public_ip: (Optional) Assign a public IP address to the ENI (Fargate launch type only). Valid values are true or false. Default false.

## Output values

* aws_ecs_service_service_id: The Amazon Resource Name (ARN) that identifies the service.
* aws_ecs_service_service_name: The name of the service.
* aws_ecs_service_service_cluster: The Amazon Resource Name (ARN) of cluster which the service runs on.
* aws_ecs_service_service_desired_count: The number of instances of the task definition.
* lb_id: Load Balancer ID.
* lb_arn: Load Balancer ARN.
* lb_arn_suffix: Load Balancer ARN Suffix.
* lb_dns_name: Load Balancer DNS Name.
* lb_zone_id: Load Balancer Zone ID.
* lb_sg_id: Load Balancer Security Group - The ID of the security group.
* lb_sg_arn: Load Balancer Security Group - The ARN of the security group.
* lb_sg_name: Load Balancer Security Group - The name of the security group.
* lb_sg_description: Load Balancer Security Group - The description of the security group.
* ecs_tasks_sg_id: ECS Tasks Security Group - The ID of the security group.
* ecs_tasks_sg_arn: ECS Tasks Security Group - The ARN of the security group.
* ecs_tasks_sg_name: ECS Tasks Security Group - The name of the security group.
* ecs_tasks_sg_description: ECS Tasks Security Group - The description of the security group.

## Other modules that you may need to use this module

The networking module should look like this:

        module "networking" {
    		    source          = "cn-terraform/networking/aws"
            version         = "2.0.3"
            name_preffix    = var.name_preffix
            profile         = var.profile
            region          = var.region
            vpc_cidr_block  = "192.168.0.0/16"
            availability_zones                          = [ "us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d" ]
            public_subnets_cidrs_per_availability_zone  = [ "192.168.0.0/19", "192.168.32.0/19", "192.168.64.0/19", "192.168.96.0/19" ]
            private_subnets_cidrs_per_availability_zone = [ "192.168.128.0/19", "192.168.160.0/19", "192.168.192.0/19", "192.168.224.0/19" ]
    	}

Check versions for this module on:
* Github Releases: <https://github.com/cn-terraform/terraform-aws-networking/releases>
* Terraform Module Registry: <https://registry.terraform.io/modules/cn-terraform/networking/aws>

The ECS cluster module should look like this:

        module "ecs-cluster" { 
            source       = "cn-terraform/ecs-cluster/aws"
            version      = "1.0.2"
            name_preffix = var.name_preffix
            profile      = var.profile
            region       = var.region
        }

Check versions for this module on:
* Github Releases: <https://github.com/cn-terraform/terraform-aws-ecs-cluster/releases>
* Terraform Module Registry: <https://registry.terraform.io/modules/cn-terraform/ecs-cluster/aws>

The task definition module should like this:

        module "td" {
    	    source          = "jnonino/ecs-fargate-task-definition/aws"
            version         = "1.0.1"
            name_preffix    = var.name_preffix
            profile         = var.profile
            region          = var.region
            container_name  = "${var.name_preffix}-<NAME>"
            container_image = "<IMAGE_NAME>:<IMAGE_TAG>"
            container_port  = <PORT>
    	}

Check versions for this module on:
* Github Releases: <https://github.com/jnonino/terraform-aws-ecs-fargate-task-definition/releases>
* Terraform Module Registry: <https://registry.terraform.io/modules/jnonino/ecs-fargate-task-definition/aws>

