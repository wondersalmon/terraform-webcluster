resource "docker_network" "homenet" {
  name   = var.docker_network
  driver = "bridge"
}