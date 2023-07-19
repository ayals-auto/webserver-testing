
##########################################################
#  Global Resources
##########################################################
# volume creation 
resource "docker_volume" "main_volume" {
  name = var.volume_name
}
# network creation
resource "docker_network" "cluster_network" {
  name   = var.network_name
  driver = "overlay"
}
# download image
resource "docker_image" "service_image" {
  name = var.docker_image
}
#########################################################


#########################################################
# Service Configuration
#########################################################
resource "docker_service" "service" {
  name = var.service_name
  
  task_spec {
   
    networks_advanced {
      name = docker_network.cluster_network.id
    }
    container_spec {
      
      image    = docker_image.service_image.name
      //hostname = "${var.service_name}-${docker_image.service_image.name}"
      healthcheck {
        test     = ["CMD", "curl", "-f", "http://localhost:${var.target_port}/healthcheck"]
        interval = "20s"
        timeout  = "5s"
        retries  = 4
      }
    }

    placement {
      constraints = [
        "node.role==manager",
      ]

      prefs = [
        "spread=node.role.manager",
      ]
      max_replicas = 3
    }

    log_driver {
      name = "json-file"
      options = {
        max-size = "10m"
        max-file = "3"
      }
    }
  }


  mode {
    replicated {
      replicas = var.num_replicated
    }
  }


  update_config {
    parallelism       = 2
    delay             = "10s"
    failure_action    = "pause"
    monitor           = "5s"
    max_failure_ratio = "0.1"
    order             = "start-first"
  }

  rollback_config {
    parallelism       = 2
    delay             = "5ms"
    failure_action    = "pause"
    monitor           = "10h"
    max_failure_ratio = "0.9"
    order             = "stop-first"
  }

  endpoint_spec {
    mode = "vip"

    ports {
      name           = "http"
      protocol       = "tcp"
      target_port    = var.target_port
      published_port = var.published_port
      publish_mode   = "ingress"
    }
  }
}