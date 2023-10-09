variable "region" {
  description = "Default region for provider"
  type        = string
}

variable "app_name" {
  description = "Name of the web application"
  type        = string
}

variable "environment_name" {
  description = "Deployment environment (dev/staging/production)"
  type        = string
}

variable "ami" {
  description = "Amazon Machine Image to use for EC2 Instance"
  type = string
}

variable "instance_type" {
  description = "ec2 instance type"
  type        = string
}

variable "user" {
  description = "defining a special tag so that an IAM user can be given access to specific resources only"
  type = string
}

variable "keyname" {
  description = "Key Pair to use to access the instance"
  type = string
}

variable "availability_zone" {
  description = "Avaliability Zone to use"
  type = string
}

locals {
  tags = {
    "environment" = var.environment_name
    "user" = var.user
    "project" = var.app_name
  }
}