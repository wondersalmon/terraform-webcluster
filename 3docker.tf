terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "~> 2.24.0"
    }
  }
}

provider "docker" {}

resource "docker_image" "webservers" {
  build {
    path = "."
  }
  name         = "webserver:${var.webserver_version}"
  keep_locally = false
}

resource "docker_image" "nginx" {
  name = "nginx:${var.loadbalancer_version}"
  keep_locally = false
}
