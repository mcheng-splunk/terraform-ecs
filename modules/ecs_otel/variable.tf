
variable "ecs_cluster_id" {
  description = "ECS cluster id"
}

variable "security_groups" {
  description = "Security group instance id"
}

variable "private_subnet_ids" {
  type        = list
  description = "The list of private subnets to place the instances in"
}

variable "aws_alb_target_group_arn"{
  description = "Alb security group arn"
}
