variable "docker_network" {
  description = "docker network name"
  type        = string
  default     = "homenet"
}

variable "webserver_version" {
  description = "Docker tag for webserver"
  type        = string
  default     = "latest"
}

variable "loadbalancer_version" {
  description = "Docker tag for loadbalancer"
  type        = string
  default     = "latest"
}

variable "webserver_port_start" {
  description = "Port range for webservers"
  type        = number
  default     = "7001"
}

variable "loadbalancer_exposed_port" {
  description = "Port for loadbalancer"
  type        = number
  default     = "6000"
}

variable "webservers_count" {
  description = "Amount of webservers"
  type        = number
  default     = "3"
}
