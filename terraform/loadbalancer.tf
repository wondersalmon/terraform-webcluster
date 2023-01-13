resource "docker_image" "nginx" {
  name = "nginx:${var.loadbalancer_version}"
  keep_locally = false
  force_remove = true
}

locals {
  module_path     = abspath(path.module)
  webserver_range = range(1, var.webservers_count+1)
}

resource "local_file" "upstream" {
  content     = templatefile("loadbalancer-config.tftpl", {
    hosts = local.webserver_range
  })
  filename = "./loadbalancer-config.conf"
}

resource "docker_container" "load-balancer" {
  name = "loadbalancer"
  hostname = "load-balancer"
  image = docker_image.nginx.image_id
  depends_on = [docker_container.webserver,local_file.upstream]
  volumes {
    container_path  = "/etc/nginx/conf.d/default.conf"
    host_path =  "${local.module_path}/loadbalancer-config.conf"
    read_only = true
  }
  networks_advanced {
    name    = docker_network.homenet.name
    aliases = ["loadbalancer"]
  }
  ports {
    internal = 80
    external = var.loadbalancer_exposed_port
  }
  healthcheck {
    test = ["CMD", "service", "nginx", "status"]
    interval = "10s"
    timeout = "1s"
    retries = 3
    }
}