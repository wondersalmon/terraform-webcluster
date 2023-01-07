locals {
  module_path     = abspath(path.module)
  webserver_range = range(1, var.webservers_count+1)
}

resource "local_file" "upstream" {
  content     = templatefile("./upstream.tftpl", {
    hosts = local.webserver_range
  })
  filename = "./upstream.conf"
}

resource "docker_container" "load-balancer" {
  name = "loadbalancer"
  hostname = "load-balancer"
  image = docker_image.nginx.image_id
  volumes {
    container_path  = "/etc/nginx/conf.d/default.conf"
    host_path =  "${local.module_path}/upstream.conf"
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