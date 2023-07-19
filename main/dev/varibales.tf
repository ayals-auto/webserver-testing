
variable "network_name" {
  default = "dev-network"
}

variable "docker_volume_name" {
  default = "dev-volume"
}

variable "docker_image" {
  default = "nginx"
}


variable "service_name" {
  default = "dev-service"
}

variable "num_replicated" {
  default = 1
}

variable "target_port" {
  default = 80
}

variable "published_port" {
  default = 8080
}

variable "volume_name" {
  default = "main"
}