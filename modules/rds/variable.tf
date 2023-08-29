variable "project_name" {
}

variable "subnet_group_name" {
  type = string
}

variable "subnet_ids" {

}
variable "allocated_storage" {
  type = number
}

variable "db_name" {
  type = string
}

variable "engine" {
  type = string
}

variable "engine_version" {
  type = string
}

variable "instance_class" {
  type = string
}

variable "username" {
  type = string
}

variable "parameter_group_name" {
  type = string
}

variable "skip_final_snapshot" {
  type = bool

}  