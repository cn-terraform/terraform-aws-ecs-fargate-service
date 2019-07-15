# AWS ECS Fargate Terraform Module #

This Terraform module deploys an AWS ECS Fargate service.

[![CircleCI](https://circleci.com/gh/jnonino/terraform-aws-ecs-fargate/tree/master.svg?style=svg)](https://circleci.com/gh/jnonino/terraform-aws-ecs-fargate/tree/master)

## Usage

Check valid versions on:
* Github Releases: <https://github.com/jnonino/terraform-aws-ecs-fargate/releases>
* Terraform Module Registry: <https://registry.terraform.io/modules/jnonino/ecs-fargate/aws>

        module "ecs-fargate": 
            source              = "jnonino/ecs-fargate/aws"
            version             = "2.0.4"
            name_preffix        = var.name_preffix
            profile             = var.profile
            region              = var.region
            vpc_id              = module.networking.vpc_id
            availability_zones  = module.networking.availability_zones
            public_subnets_ids  = module.networking.public_subnets_ids
            private_subnets_ids = module.networking.private_subnets_ids
            container_name               = "<CONTAINER_NAME>"
            container_image              = "<IMAGE_NAME>:<IMAGE_TAG>"
            container_cpu                = 1024
            container_memory             = 8192
            container_memory_reservation = 2048
            essential                    = true
            container_port               = 9000
            environment = [
                {
                    name  = "<VARIABLE_NAME>"
                    value = "<VARIABLE_VALUE>"
                }
            ]
        }

Check the section "Other modules that you may need to use this module" for details about modules mentioned in the usage example.
<<<<<<< HEAD
=======

## Input values
* name_preffix: Name preffix for resources on AWS.
* profile: AWS API key credentials to use.
* region: AWS Region the infrastructure is hosted in.

* task_definition_arn: (Required) The full ARN of the task definition that you want to run in your service.
* ecs_cluster_arn: ARN of an ECS cluster
* desired_count: (Optional) The number of instances of the task definition to place and keep running. Defaults to 1.
* platform_version: (Optional) The platform version on which to run your service. Defaults to LATEST. More information about Fargate platform versions can be found in the AWS ECS User Guide.
* deployment_maximum_percent: (Optional) The upper limit (as a percentage of the service's desiredCount) of the number of running tasks that can be running in a service during a deployment.
* deployment_minimum_healthy_percent: (Optional) The lower limit (as a percentage of the service's desiredCount) of the number of running tasks that must remain running and healthy in a service during a deployment.
* enable_ecs_managed_tags: (Optional) Specifies whether to enable Amazon ECS managed tags for the tasks within the service.
* propagate_tags: (Optional) Specifies whether to propagate the tags from the task definition or the service to the tasks. The valid values are SERVICE and TASK_DEFINITION. Default to SERVICE
* ordered_placement_strategy: (Optional) Service level strategy rules that are taken into consideration during task placement. List from top to bottom in order of precedence. The maximum number of ordered_placement_strategy blocks is 5. This is a list of maps where each map should contain "id" and "field".
* health_check_grace_period_seconds: (Optional) Seconds to ignore failing load balancer health checks on newly instantiated tasks to prevent premature shutdown, up to 2147483647. Only valid for services configured to use load balancers.
* placement_constraints: (Optional) rules that are taken into consideration during task placement. Maximum number of placement_constraints is 10. This is a list of maps, where each map should contain "type" and "expression".
* service_registries: (Optional) The service discovery registries for the service. The maximum number of service_registries blocks is 1. This is a map that should contain the following fields "registry_arn", "port", "container_port" and "container_name".
* subnets: The subnets associated with the task or service.
* security_groups: (Optional) The security groups associated with the task or service. If you do not specify a security group, the default security group for the VPC is used.
* assign_public_ip: (Optional) Assign a public IP address to the ENI (Fargate launch type only). Valid values are true or false. Default false.
>>>>>>> Reorganizing code and adding variables to service

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
    		source          = "jnonino/networking/aws"
            version         = "2.0.3"
<<<<<<< HEAD
            name_preffix    = var.name_preffix
            profile         = var.profile
            region          = var.region
=======
            name_preffix    = "base"
            profile         = "aws_profile"
            region          = "us-east-1"
>>>>>>> Reorganizing code and adding variables to service
            vpc_cidr_block  = "192.168.0.0/16"
            availability_zones                          = [ "us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d" ]
            public_subnets_cidrs_per_availability_zone  = [ "192.168.0.0/19", "192.168.32.0/19", "192.168.64.0/19", "192.168.96.0/19" ]
            private_subnets_cidrs_per_availability_zone = [ "192.168.128.0/19", "192.168.160.0/19", "192.168.192.0/19", "192.168.224.0/19" ]
    	}

Check versions for this module on:
* Github Releases: <https://github.com/jnonino/terraform-aws-networking/releases>
* Terraform Module Registry: <https://registry.terraform.io/modules/jnonino/networking/aws>

