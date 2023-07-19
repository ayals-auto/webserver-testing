module "create_prod_env" {
  source = "../../module/service_module"
  network_name = var.network_name
  service_name = var.service_name
  docker_volume_name = var.docker_volume_name
  docker_image = var.docker_image
  num_replicated = var.num_replicated
}