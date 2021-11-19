provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

module "ecs" {
  source = "./modules/ecs"

  environment          = var.environment
  cluster              = var.environment
  cloudwatch_prefix    = var.environment #See ecs_instances module when to set this and when not!
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
  max_size             = var.max_size
  min_size             = var.min_size
  desired_capacity     = var.desired_capacity
  key_name             = aws_key_pair.ecs.key_name
  instance_type        = var.instance_type
  ecs_aws_ami          = var.aws_ecs_ami
}

resource "aws_key_pair" "ecs" {
  key_name   = "ecs-key-${var.environment}"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDBz7QikdpOJeYukJBC/UfR5ltzUP2lSs7DzT216nfAqwNx/diP8ywASZdKlWJFb9ZtyK+CQf3D8BDLoA283NpEaULrtK200Crrxxw5qsd0ZWu47sIkN28Z4MQKH636I6++u/V4KGd25/ZQ0+neleuixynaRWt02esR1sa2x5K4h+WM1h0MslOVowccEqRq7WKdGu9KixPI1eh6164EAundWvxfdA6qphD9kbGHs7RqNz8K6/nEG9reb0uiBv5F/Bm4tW4t63mjk653pJvpL+dYAe0rg+Cvf1XnnY7oLegH2WBQmhtMfkg07Cbzn/rqS80203uXoxgvBOonOT+58uzz melvin"
}

variable "environment" {
  description = "A name to describe the environment we're creating."
}
variable "aws_profile" {
  description = "The AWS-CLI profile for the account to create resources in."
}
variable "aws_region" {
  description = "The AWS region to create resources in."
}
variable "aws_ecs_ami" {
  description = "The AMI to seed ECS instances with."
}
variable "vpc_cidr" {
  description = "The IP range to attribute to the virtual network."
}
variable "public_subnet_cidrs" {
  description = "The IP ranges to use for the public subnets in your VPC."
  type        = list(any)
}
variable "private_subnet_cidrs" {
  description = "The IP ranges to use for the private subnets in your VPC."
  type        = list(any)
}
variable "availability_zones" {
  description = "The AWS availability zones to create subnets in."
  type        = list(any)
}
variable "max_size" {
  description = "Maximum number of instances in the ECS cluster."
}
variable "min_size" {
  description = "Minimum number of instances in the ECS cluster."
}
variable "desired_capacity" {
  description = "Ideal number of instances in the ECS cluster."
}
variable "instance_type" {
  description = "Size of instances in the ECS cluster."
}

output "default_alb_target_group" {
  value = module.ecs.default_alb_target_group
}
