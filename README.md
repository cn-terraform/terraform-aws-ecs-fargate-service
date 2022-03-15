# AWS ECS Fargate Terraform Module #

This Terraform module deploys an AWS ECS Fargate service.

[![](https://github.com/cn-terraform/terraform-aws-ecs-fargate-service/workflows/terraform/badge.svg)](https://github.com/cn-terraform/terraform-aws-ecs-fargate-service/actions?query=workflow%3Aterraform)
[![](https://img.shields.io/github/license/cn-terraform/terraform-aws-ecs-fargate-service)](https://github.com/cn-terraform/terraform-aws-ecs-fargate-service)
[![](https://img.shields.io/github/issues/cn-terraform/terraform-aws-ecs-fargate-service)](https://github.com/cn-terraform/terraform-aws-ecs-fargate-service)
[![](https://img.shields.io/github/issues-closed/cn-terraform/terraform-aws-ecs-fargate-service)](https://github.com/cn-terraform/terraform-aws-ecs-fargate-service)
[![](https://img.shields.io/github/languages/code-size/cn-terraform/terraform-aws-ecs-fargate-service)](https://github.com/cn-terraform/terraform-aws-ecs-fargate-service)
[![](https://img.shields.io/github/repo-size/cn-terraform/terraform-aws-ecs-fargate-service)](https://github.com/cn-terraform/terraform-aws-ecs-fargate-service)

## Usage

Check valid versions on:
* Github Releases: <https://github.com/cn-terraform/terraform-aws-ecs-fargate-service/releases>
* Terraform Module Registry: <https://registry.terraform.io/modules/cn-terraform/ecs-fargate-service/aws>

## Other modules that you may need to use this module

The Networking module:
* Github Releases: <https://github.com/cn-terraform/terraform-aws-networking/releases>
* Terraform Module Registry: <https://registry.terraform.io/modules/cn-terraform/networking/aws>

The ECS cluster module:
* Github Releases: <https://github.com/cn-terraform/terraform-aws-ecs-cluster/releases>
* Terraform Module Registry: <https://registry.terraform.io/modules/cn-terraform/ecs-cluster/aws>

The ECS Task Definition:
* Github Releases: <https://github.com/cn-terraform/terraform-aws-ecs-fargate-task-definition/releases>
* Terraform Module Registry: <https://registry.terraform.io/modules/cn-terraform/ecs-fargate-task-definition/aws>

The ECS ALB module:
* Github Releases: <https://github.com/cn-terraform/terraform-aws-ecs-alb/releases>
* Terraform Module Registry: <https://registry.terraform.io/modules/cn-terraform/ecs-alb>

## Install pre commit hooks.

Pleas run this command right after cloning the repository.

        pre-commit install

For that you may need to install the folowwing tools:
* [Pre-commit](https://pre-commit.com/)
* [Terraform Docs](https://terraform-docs.io/)

In order to run all checks at any point run the following command:

        pre-commit run --all-files

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4 |
| <a name="requirement_local"></a> [local](#requirement\_local) | 2.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.1.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ecs-alb"></a> [ecs-alb](#module\_ecs-alb) | cn-terraform/ecs-alb/aws | 1.0.16 |
| <a name="module_ecs-autoscaling"></a> [ecs-autoscaling](#module\_ecs-autoscaling) | cn-terraform/ecs-service-autoscaling/aws | 1.0.6 |

## Resources

| Name | Type |
|------|------|
| [aws_ecs_service.service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_security_group.ecs_tasks_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ingress_through_http](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ingress_through_https](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_certificates_arn_for_https_listeners"></a> [additional\_certificates\_arn\_for\_https\_listeners](#input\_additional\_certificates\_arn\_for\_https\_listeners) | (Optional) List of SSL server certificate ARNs for HTTPS listener. Use it if you need to set additional certificates besides default\_certificate\_arn | `list(any)` | `[]` | no |
| <a name="input_assign_public_ip"></a> [assign\_public\_ip](#input\_assign\_public\_ip) | (Optional) Assign a public IP address to the ENI (Fargate launch type only). If true service will be associated with public subnets. Default false. | `bool` | `false` | no |
| <a name="input_block_s3_bucket_public_access"></a> [block\_s3\_bucket\_public\_access](#input\_block\_s3\_bucket\_public\_access) | (Optional) If true, public access to the S3 bucket will be blocked. | `bool` | `false` | no |
| <a name="input_container_name"></a> [container\_name](#input\_container\_name) | Name of the running container | `any` | n/a | yes |
| <a name="input_default_certificate_arn"></a> [default\_certificate\_arn](#input\_default\_certificate\_arn) | (Optional) The ARN of the default SSL server certificate. Required if var.https\_ports is set. | `string` | `null` | no |
| <a name="input_deployment_controller"></a> [deployment\_controller](#input\_deployment\_controller) | (Optional) Deployment controller | `list(string)` | `[]` | no |
| <a name="input_deployment_maximum_percent"></a> [deployment\_maximum\_percent](#input\_deployment\_maximum\_percent) | (Optional) The upper limit (as a percentage of the service's desiredCount) of the number of running tasks that can be running in a service during a deployment. | `number` | `200` | no |
| <a name="input_deployment_minimum_healthy_percent"></a> [deployment\_minimum\_healthy\_percent](#input\_deployment\_minimum\_healthy\_percent) | (Optional) The lower limit (as a percentage of the service's desiredCount) of the number of running tasks that must remain running and healthy in a service during a deployment. | `number` | `100` | no |
| <a name="input_desired_count"></a> [desired\_count](#input\_desired\_count) | (Optional) The number of instances of the task definition to place and keep running. Defaults to 0. | `number` | `1` | no |
| <a name="input_ecs_cluster_arn"></a> [ecs\_cluster\_arn](#input\_ecs\_cluster\_arn) | ARN of an ECS cluster | `any` | n/a | yes |
| <a name="input_ecs_cluster_name"></a> [ecs\_cluster\_name](#input\_ecs\_cluster\_name) | (Optional) Name of the ECS cluster. Required only if autoscaling is enabled | `string` | `null` | no |
| <a name="input_ecs_tasks_sg_allow_egress_to_anywhere"></a> [ecs\_tasks\_sg\_allow\_egress\_to\_anywhere](#input\_ecs\_tasks\_sg\_allow\_egress\_to\_anywhere) | (Optional) If true an egress rule will be created to allow traffic to anywhere (0.0.0.0/0). If false no egress rule will be created. Defaults to true | `bool` | `true` | no |
| <a name="input_enable_autoscaling"></a> [enable\_autoscaling](#input\_enable\_autoscaling) | (Optional) If true, autoscaling alarms will be created. | `bool` | `true` | no |
| <a name="input_enable_ecs_managed_tags"></a> [enable\_ecs\_managed\_tags](#input\_enable\_ecs\_managed\_tags) | (Optional) Specifies whether to enable Amazon ECS managed tags for the tasks within the service. | `bool` | `false` | no |
| <a name="input_enable_execute_command"></a> [enable\_execute\_command](#input\_enable\_execute\_command) | (Optional) Specifies whether to enable Amazon ECS Exec for the tasks within the service. | `bool` | `false` | no |
| <a name="input_force_new_deployment"></a> [force\_new\_deployment](#input\_force\_new\_deployment) | (Optional) Enable to force a new task deployment of the service. This can be used to update tasks to use a newer Docker image with same image/tag combination (e.g. myimage:latest), roll Fargate tasks onto a newer platform version, or immediately deploy ordered\_placement\_strategy and placement\_constraints updates. | `bool` | `false` | no |
| <a name="input_health_check_grace_period_seconds"></a> [health\_check\_grace\_period\_seconds](#input\_health\_check\_grace\_period\_seconds) | (Optional) Seconds to ignore failing load balancer health checks on newly instantiated tasks to prevent premature shutdown, up to 2147483647. Only valid for services configured to use load balancers. | `number` | `0` | no |
| <a name="input_lb_deregistration_delay"></a> [lb\_deregistration\_delay](#input\_lb\_deregistration\_delay) | (Optional) The amount time for Elastic Load Balancing to wait before changing the state of a deregistering target from draining to unused. The range is 0-3600 seconds. The default value is 300 seconds. | `number` | `300` | no |
| <a name="input_lb_drop_invalid_header_fields"></a> [lb\_drop\_invalid\_header\_fields](#input\_lb\_drop\_invalid\_header\_fields) | (Optional) Indicates whether HTTP headers with header fields that are not valid are removed by the load balancer (true) or routed to targets (false). The default is false. Elastic Load Balancing requires that message header names contain only alphanumeric characters and hyphens. | `bool` | `false` | no |
| <a name="input_lb_enable_cross_zone_load_balancing"></a> [lb\_enable\_cross\_zone\_load\_balancing](#input\_lb\_enable\_cross\_zone\_load\_balancing) | (Optional) If true, cross-zone load balancing of the load balancer will be enabled. Defaults to false. | `bool` | `false` | no |
| <a name="input_lb_enable_deletion_protection"></a> [lb\_enable\_deletion\_protection](#input\_lb\_enable\_deletion\_protection) | (Optional) If true, deletion of the load balancer will be disabled via the AWS API. This will prevent Terraform from deleting the load balancer. Defaults to false. | `bool` | `false` | no |
| <a name="input_lb_enable_http2"></a> [lb\_enable\_http2](#input\_lb\_enable\_http2) | (Optional) Indicates whether HTTP/2 is enabled in the load balancer. Defaults to true. | `bool` | `true` | no |
| <a name="input_lb_http_ingress_cidr_blocks"></a> [lb\_http\_ingress\_cidr\_blocks](#input\_lb\_http\_ingress\_cidr\_blocks) | List of CIDR blocks to allowed to access the Load Balancer through HTTP | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_lb_http_ingress_prefix_list_ids"></a> [lb\_http\_ingress\_prefix\_list\_ids](#input\_lb\_http\_ingress\_prefix\_list\_ids) | List of prefix list IDs blocks to allowed to access the Load Balancer through HTTP | `list(string)` | `[]` | no |
| <a name="input_lb_http_ports"></a> [lb\_http\_ports](#input\_lb\_http\_ports) | Map containing objects to define listeners behaviour based on type field. If type field is `forward`, include listener\_port and the target\_group\_port. For `redirect` type, include listener port, host, path, port, protocol, query and status\_code. For `fixed-response`, include listener\_port, content\_type, message\_body and status\_code | `map(any)` | <pre>{<br>  "default_http": {<br>    "listener_port": 80,<br>    "target_group_port": 80,<br>    "type": "forward"<br>  }<br>}</pre> | no |
| <a name="input_lb_https_ingress_cidr_blocks"></a> [lb\_https\_ingress\_cidr\_blocks](#input\_lb\_https\_ingress\_cidr\_blocks) | List of CIDR blocks to allowed to access the Load Balancer through HTTPS | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_lb_https_ingress_prefix_list_ids"></a> [lb\_https\_ingress\_prefix\_list\_ids](#input\_lb\_https\_ingress\_prefix\_list\_ids) | List of prefix list IDs blocks to allowed to access the Load Balancer through HTTPS | `list(string)` | `[]` | no |
| <a name="input_lb_https_ports"></a> [lb\_https\_ports](#input\_lb\_https\_ports) | Map containing objects to define listeners behaviour based on type field. If type field is `forward`, include listener\_port and the target\_group\_port. For `redirect` type, include listener port, host, path, port, protocol, query and status\_code. For `fixed-response`, include listener\_port, content\_type, message\_body and status\_code | `map(any)` | <pre>{<br>  "default_http": {<br>    "listener_port": 443,<br>    "target_group_port": 443,<br>    "type": "forward"<br>  }<br>}</pre> | no |
| <a name="input_lb_idle_timeout"></a> [lb\_idle\_timeout](#input\_lb\_idle\_timeout) | (Optional) The time in seconds that the connection is allowed to be idle. Default: 60. | `number` | `60` | no |
| <a name="input_lb_internal"></a> [lb\_internal](#input\_lb\_internal) | (Optional) If true, the LB will be internal. | `bool` | `false` | no |
| <a name="input_lb_ip_address_type"></a> [lb\_ip\_address\_type](#input\_lb\_ip\_address\_type) | (Optional) The type of IP addresses used by the subnets for your load balancer. The possible values are ipv4 and dualstack. Defaults to ipv4 | `string` | `"ipv4"` | no |
| <a name="input_lb_load_balancing_algorithm_type"></a> [lb\_load\_balancing\_algorithm\_type](#input\_lb\_load\_balancing\_algorithm\_type) | (Optional) Determines how the load balancer selects targets when routing requests. The value is round\_robin or least\_outstanding\_requests. The default is round\_robin. | `string` | `"round_robin"` | no |
| <a name="input_lb_security_groups"></a> [lb\_security\_groups](#input\_lb\_security\_groups) | (Optional) A list of security group IDs to assign to the LB. | `list(string)` | `[]` | no |
| <a name="input_lb_slow_start"></a> [lb\_slow\_start](#input\_lb\_slow\_start) | (Optional) The amount time for targets to warm up before the load balancer sends them a full share of requests. The range is 30-900 seconds or 0 to disable. The default value is 0 seconds. | `number` | `0` | no |
| <a name="input_lb_stickiness"></a> [lb\_stickiness](#input\_lb\_stickiness) | (Optional) A Stickiness block. Provide three fields. type, the type of sticky sessions. The only current possible value is lb\_cookie. cookie\_duration, the time period, in seconds, during which requests from a client should be routed to the same target. After this time period expires, the load balancer-generated cookie is considered stale. The range is 1 second to 1 week (604800 seconds). The default value is 1 day (86400 seconds). enabled, boolean to enable / disable stickiness. Default is true. | <pre>object({<br>    type            = string<br>    cookie_duration = string<br>    enabled         = bool<br>  })</pre> | <pre>{<br>  "cookie_duration": 86400,<br>  "enabled": true,<br>  "type": "lb_cookie"<br>}</pre> | no |
| <a name="input_lb_target_group_health_check_enabled"></a> [lb\_target\_group\_health\_check\_enabled](#input\_lb\_target\_group\_health\_check\_enabled) | (Optional) Indicates whether health checks are enabled. Defaults to true. | `bool` | `true` | no |
| <a name="input_lb_target_group_health_check_healthy_threshold"></a> [lb\_target\_group\_health\_check\_healthy\_threshold](#input\_lb\_target\_group\_health\_check\_healthy\_threshold) | (Optional) The number of consecutive health checks successes required before considering an unhealthy target healthy. Defaults to 3. | `number` | `3` | no |
| <a name="input_lb_target_group_health_check_interval"></a> [lb\_target\_group\_health\_check\_interval](#input\_lb\_target\_group\_health\_check\_interval) | (Optional) The approximate amount of time, in seconds, between health checks of an individual target. Minimum value 5 seconds, Maximum value 300 seconds. Default 30 seconds. | `number` | `30` | no |
| <a name="input_lb_target_group_health_check_matcher"></a> [lb\_target\_group\_health\_check\_matcher](#input\_lb\_target\_group\_health\_check\_matcher) | The HTTP codes to use when checking for a successful response from a target. You can specify multiple values (for example, "200,202") or a range of values (for example, "200-299"). Default is 200. | `string` | `"200"` | no |
| <a name="input_lb_target_group_health_check_path"></a> [lb\_target\_group\_health\_check\_path](#input\_lb\_target\_group\_health\_check\_path) | The destination for the health check request. | `string` | `"/"` | no |
| <a name="input_lb_target_group_health_check_timeout"></a> [lb\_target\_group\_health\_check\_timeout](#input\_lb\_target\_group\_health\_check\_timeout) | (Optional) The amount of time, in seconds, during which no response means a failed health check. The range is 2 to 120 seconds, and the default is 5 seconds. | `number` | `5` | no |
| <a name="input_lb_target_group_health_check_unhealthy_threshold"></a> [lb\_target\_group\_health\_check\_unhealthy\_threshold](#input\_lb\_target\_group\_health\_check\_unhealthy\_threshold) | (Optional) The number of consecutive health check failures required before considering the target unhealthy. Defaults to 3. | `number` | `3` | no |
| <a name="input_max_cpu_evaluation_period"></a> [max\_cpu\_evaluation\_period](#input\_max\_cpu\_evaluation\_period) | The number of periods over which data is compared to the specified threshold for max cpu metric alarm | `string` | `"3"` | no |
| <a name="input_max_cpu_period"></a> [max\_cpu\_period](#input\_max\_cpu\_period) | The period in seconds over which the specified statistic is applied for max cpu metric alarm | `string` | `"60"` | no |
| <a name="input_max_cpu_threshold"></a> [max\_cpu\_threshold](#input\_max\_cpu\_threshold) | Threshold for max CPU usage | `string` | `"85"` | no |
| <a name="input_min_cpu_evaluation_period"></a> [min\_cpu\_evaluation\_period](#input\_min\_cpu\_evaluation\_period) | The number of periods over which data is compared to the specified threshold for min cpu metric alarm | `string` | `"3"` | no |
| <a name="input_min_cpu_period"></a> [min\_cpu\_period](#input\_min\_cpu\_period) | The period in seconds over which the specified statistic is applied for min cpu metric alarm | `string` | `"60"` | no |
| <a name="input_min_cpu_threshold"></a> [min\_cpu\_threshold](#input\_min\_cpu\_threshold) | Threshold for min CPU usage | `string` | `"10"` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Name prefix for resources on AWS | `any` | n/a | yes |
| <a name="input_ordered_placement_strategy"></a> [ordered\_placement\_strategy](#input\_ordered\_placement\_strategy) | (Optional) Service level strategy rules that are taken into consideration during task placement. List from top to bottom in order of precedence. The maximum number of ordered\_placement\_strategy blocks is 5. This is a list of maps where each map should contain "id" and "field" | `list(any)` | `[]` | no |
| <a name="input_placement_constraints"></a> [placement\_constraints](#input\_placement\_constraints) | (Optional) rules that are taken into consideration during task placement. Maximum number of placement\_constraints is 10. This is a list of maps, where each map should contain "type" and "expression" | `list(any)` | `[]` | no |
| <a name="input_platform_version"></a> [platform\_version](#input\_platform\_version) | (Optional) The platform version on which to run your service. Defaults to 1.4.0. More information about Fargate platform versions can be found in the AWS ECS User Guide. | `string` | `"1.4.0"` | no |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | The private subnets associated with the task or service. | `list(any)` | n/a | yes |
| <a name="input_propagate_tags"></a> [propagate\_tags](#input\_propagate\_tags) | (Optional) Specifies whether to propagate the tags from the task definition or the service to the tasks. The valid values are SERVICE and TASK\_DEFINITION. Default to SERVICE | `string` | `"SERVICE"` | no |
| <a name="input_public_subnets"></a> [public\_subnets](#input\_public\_subnets) | The public subnets associated with the task or service. | `list(any)` | n/a | yes |
| <a name="input_scale_target_max_capacity"></a> [scale\_target\_max\_capacity](#input\_scale\_target\_max\_capacity) | The max capacity of the scalable target | `number` | `5` | no |
| <a name="input_scale_target_min_capacity"></a> [scale\_target\_min\_capacity](#input\_scale\_target\_min\_capacity) | The min capacity of the scalable target | `number` | `1` | no |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | (Optional) The security groups associated with the task or service. If you do not specify a security group, the default security group for the VPC is used. | `list(any)` | `[]` | no |
| <a name="input_service_registries"></a> [service\_registries](#input\_service\_registries) | (Optional) The service discovery registries for the service. The maximum number of service\_registries blocks is 1. This is a map that should contain the following fields "registry\_arn", "port", "container\_port" and "container\_name" | `map(any)` | `{}` | no |
| <a name="input_ssl_policy"></a> [ssl\_policy](#input\_ssl\_policy) | (Optional) The name of the SSL Policy for the listener. . Required if var.https\_ports is set. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Resource tags | `map(string)` | `{}` | no |
| <a name="input_task_definition_arn"></a> [task\_definition\_arn](#input\_task\_definition\_arn) | (Required) The full ARN of the task definition that you want to run in your service. | `any` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of the VPC | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_ecs_service_service_cluster"></a> [aws\_ecs\_service\_service\_cluster](#output\_aws\_ecs\_service\_service\_cluster) | The Amazon Resource Name (ARN) of cluster which the service runs on. |
| <a name="output_aws_ecs_service_service_desired_count"></a> [aws\_ecs\_service\_service\_desired\_count](#output\_aws\_ecs\_service\_service\_desired\_count) | The number of instances of the task definition |
| <a name="output_aws_ecs_service_service_id"></a> [aws\_ecs\_service\_service\_id](#output\_aws\_ecs\_service\_service\_id) | The Amazon Resource Name (ARN) that identifies the service. |
| <a name="output_aws_ecs_service_service_name"></a> [aws\_ecs\_service\_service\_name](#output\_aws\_ecs\_service\_service\_name) | The name of the service. |
| <a name="output_aws_lb_lb_arn"></a> [aws\_lb\_lb\_arn](#output\_aws\_lb\_lb\_arn) | The ARN of the load balancer (matches id). |
| <a name="output_aws_lb_lb_arn_suffix"></a> [aws\_lb\_lb\_arn\_suffix](#output\_aws\_lb\_lb\_arn\_suffix) | The ARN suffix for use with CloudWatch Metrics. |
| <a name="output_aws_lb_lb_dns_name"></a> [aws\_lb\_lb\_dns\_name](#output\_aws\_lb\_lb\_dns\_name) | The DNS name of the load balancer. |
| <a name="output_aws_lb_lb_id"></a> [aws\_lb\_lb\_id](#output\_aws\_lb\_lb\_id) | The ARN of the load balancer (matches arn). |
| <a name="output_aws_lb_lb_zone_id"></a> [aws\_lb\_lb\_zone\_id](#output\_aws\_lb\_lb\_zone\_id) | The canonical hosted zone ID of the load balancer (to be used in a Route 53 Alias record). |
| <a name="output_aws_security_group_lb_access_sg_arn"></a> [aws\_security\_group\_lb\_access\_sg\_arn](#output\_aws\_security\_group\_lb\_access\_sg\_arn) | The ARN of the security group |
| <a name="output_aws_security_group_lb_access_sg_description"></a> [aws\_security\_group\_lb\_access\_sg\_description](#output\_aws\_security\_group\_lb\_access\_sg\_description) | The description of the security group |
| <a name="output_aws_security_group_lb_access_sg_egress"></a> [aws\_security\_group\_lb\_access\_sg\_egress](#output\_aws\_security\_group\_lb\_access\_sg\_egress) | The egress rules. |
| <a name="output_aws_security_group_lb_access_sg_id"></a> [aws\_security\_group\_lb\_access\_sg\_id](#output\_aws\_security\_group\_lb\_access\_sg\_id) | The ID of the security group |
| <a name="output_aws_security_group_lb_access_sg_ingress"></a> [aws\_security\_group\_lb\_access\_sg\_ingress](#output\_aws\_security\_group\_lb\_access\_sg\_ingress) | The ingress rules. |
| <a name="output_aws_security_group_lb_access_sg_name"></a> [aws\_security\_group\_lb\_access\_sg\_name](#output\_aws\_security\_group\_lb\_access\_sg\_name) | The name of the security group |
| <a name="output_aws_security_group_lb_access_sg_owner_id"></a> [aws\_security\_group\_lb\_access\_sg\_owner\_id](#output\_aws\_security\_group\_lb\_access\_sg\_owner\_id) | The owner ID. |
| <a name="output_aws_security_group_lb_access_sg_vpc_id"></a> [aws\_security\_group\_lb\_access\_sg\_vpc\_id](#output\_aws\_security\_group\_lb\_access\_sg\_vpc\_id) | The VPC ID. |
| <a name="output_ecs_tasks_sg_arn"></a> [ecs\_tasks\_sg\_arn](#output\_ecs\_tasks\_sg\_arn) | ${var.name\_prefix} ECS Tasks Security Group - The ARN of the security group |
| <a name="output_ecs_tasks_sg_description"></a> [ecs\_tasks\_sg\_description](#output\_ecs\_tasks\_sg\_description) | ${var.name\_prefix} ECS Tasks Security Group - The description of the security group |
| <a name="output_ecs_tasks_sg_id"></a> [ecs\_tasks\_sg\_id](#output\_ecs\_tasks\_sg\_id) | ${var.name\_prefix} ECS Tasks Security Group - The ID of the security group |
| <a name="output_ecs_tasks_sg_name"></a> [ecs\_tasks\_sg\_name](#output\_ecs\_tasks\_sg\_name) | ${var.name\_prefix} ECS Tasks Security Group - The name of the security group |
| <a name="output_lb_http_listeners_arns"></a> [lb\_http\_listeners\_arns](#output\_lb\_http\_listeners\_arns) | List of HTTP Listeners ARNs |
| <a name="output_lb_http_listeners_ids"></a> [lb\_http\_listeners\_ids](#output\_lb\_http\_listeners\_ids) | List of HTTP Listeners IDs |
| <a name="output_lb_http_tgs_arns"></a> [lb\_http\_tgs\_arns](#output\_lb\_http\_tgs\_arns) | List of HTTP Target Groups ARNs |
| <a name="output_lb_http_tgs_ids"></a> [lb\_http\_tgs\_ids](#output\_lb\_http\_tgs\_ids) | List of HTTP Target Groups IDs |
| <a name="output_lb_http_tgs_names"></a> [lb\_http\_tgs\_names](#output\_lb\_http\_tgs\_names) | List of HTTP Target Groups Names |
| <a name="output_lb_https_listeners_arns"></a> [lb\_https\_listeners\_arns](#output\_lb\_https\_listeners\_arns) | List of HTTPS Listeners ARNs |
| <a name="output_lb_https_listeners_ids"></a> [lb\_https\_listeners\_ids](#output\_lb\_https\_listeners\_ids) | List of HTTPS Listeners IDs |
| <a name="output_lb_https_tgs_arns"></a> [lb\_https\_tgs\_arns](#output\_lb\_https\_tgs\_arns) | List of HTTPS Target Groups ARNs |
| <a name="output_lb_https_tgs_ids"></a> [lb\_https\_tgs\_ids](#output\_lb\_https\_tgs\_ids) | List of HTTPS Target Groups IDs |
| <a name="output_lb_https_tgs_names"></a> [lb\_https\_tgs\_names](#output\_lb\_https\_tgs\_names) | List of HTTPS Target Groups Names |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
