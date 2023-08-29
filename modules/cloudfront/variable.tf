#Define Application Load Balancer Variable
variable "allowed_methods" {
  type = list(string)
}

variable "cached_methods" {
  type = list(string)
}

variable "cookies_forward" {
  type = string
}

variable "cloudfront_default_certificate" {
  type = bool
}

variable "locations" {
  type = list(string)
}

variable "alb_domain_name" {

}

variable "project_name" {
  type = string
}

