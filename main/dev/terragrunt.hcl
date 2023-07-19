include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../module/service_module"
}

inputs = {
  network_name       = "dev-network"
  service_name       = "dev-service"
  docker_volume_name = "dev-volume"
  docker_image       = "devonfire/web-server-testing"
  num_replicated     = 2
  target_port        = 3000
  published_port     = 8081
}



