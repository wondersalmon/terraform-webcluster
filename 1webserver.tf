resource "docker_container" "webserver" {
 
  count = var.webservers_count
  name  = "webserver${count.index+1}"
  hostname  = "web-server-${count.index+1}"
  image = docker_image.webservers.image_id
  networks_advanced {
    name    = docker_network.homenet.name
    aliases = ["webserver${count.index}"]
  }
  ports {
    internal = 6666
    external = var.webserver_port_start+ count.index
  }
   healthcheck {
    test = ["CMD", "service", "nginx", "status"]
    interval = "10s"
    timeout = "1s"
    retries = 3
    }
 }