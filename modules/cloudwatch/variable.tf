variable "asg_name" {

}

variable "asg_scale_up_policy_arn" {

}

variable "asg_scale_down_policy_arn" {

}

variable "project_name" {
  type = string
}

variable "comparison_operator" {
  type = string
}

variable "evaluation_periods" {
  type = number
}

variable "metric_name" {
  type = string
}

variable "namespace" {
  type = string
}

variable "period" {
  type = number
}

variable "statistic" {
  type = string
}

variable "threshold_up" {
  type = string
}

variable "threshold_down" {
  type = string
}