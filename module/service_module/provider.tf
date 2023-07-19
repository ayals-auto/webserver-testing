# Set the required provider and versions
terraform {
  terraform {
  backend "s3" {}
}
  required_providers {
    # We recommend pinning to the specific version of the Docker Provider you're using
    # since new versions are released frequently
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

# Configure the docker provider
provider "docker" {
  alias  = "main"
  host = "unix:///var/run/docker.sock"
}
