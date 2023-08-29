variable "max_size" {
  type = number
}

variable "min_size" {
  type = number
}

variable "health_check_grace_period" {
  type = number
}

variable "health_check_type" {
  type = string
}

variable "force_delete" {
  type = bool
}

variable "metrics_granularity" {
  type = string
}

variable "project_name" {
  type = string
}

variable "scaling_adjustment_up" {
  type = number
}

variable "scaling_adjustment_down" {
  type = number
}

variable "adjustment_type" {
  type = string
}

variable "cooldown" {
  type = string
}

variable "desired_capacity" {
  type = number
}

variable "vpc_zone_identifier" {
}

variable "target_group_arns" {

}
variable "launch_template_id" {

}

variable "launch_template_version" {

}
