#Define variable for Load Balancer
variable "alb_name" {
  type = string
}

variable "internal" {
  type = bool
}

variable "load_balancer_type" {
  type = string
}

variable "enable_deletion_protection" {
  type = bool
}

#Define Variable for Target Group
variable "tg_name" {
  type = string
}

variable "tg_type" {
  type = string
}

#Define variable External Value

variable "security_group_ids" {
}

variable "subnet_ids" {
}

variable "vpc_id" {
  type = string
}

variable "project_name" {
  type = string
}