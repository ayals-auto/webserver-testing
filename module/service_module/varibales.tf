
variable "network_name" {
  default = "prod-network"
}

variable "docker_volume_name" {
  default = "server1"
}

variable "docker_image" {
  default = "nginx"
}


variable "service_name" {
  default = "main"
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