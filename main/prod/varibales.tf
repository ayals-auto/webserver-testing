
variable "network_name" {
  default = "prod-network"
}

variable "docker_volume_name" {
  default = "prod-volume"
}

variable "docker_image" {
  default = "devonfire/web-server-testing"
}

variable "service_name" {
  default = "prod-service"
}

variable "num_replicated" {
  default = 2
}

variable "target_port" {
  default = 3000
}

variable "published_port" {
  default = 8080
}

variable "volume_name" {
  default = "main"
}