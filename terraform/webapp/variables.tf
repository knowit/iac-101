variable "name" {
    type = string
}

variable "namespace" {
    type = string
    default = "roma"
}

variable "replicas" {
    type = number
    default = 1
}

variable "image" {
  type = string
}

variable "port" {
  type = number
}

variable "service_type" {
  type = string
  default = "LoadBalancer"
}

variable "env_variables" {
    type = map
}