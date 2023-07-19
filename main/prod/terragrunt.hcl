include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../module/service_module"
}

inputs = {
  network_name       = "prod-network"
  service_name       = "prod-service"
  docker_volume_name = "prod-volume"
  docker_image       = "devonfire/web-server-testing"
  num_replicated     = 2
  target_port        = 3000
  published_port     = 8080
}



