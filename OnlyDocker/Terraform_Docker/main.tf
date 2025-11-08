
locals {
  net_name        = "${var.project}-net"
  backend_name    = "backend"
  frontend_name   = "frontend"
  frontend_image  = "${var.images.frontend_name}:${var.images.frontend_tag}"
  backend_image   = "${var.images.backend_name}:${var.images.backend_tag}"
}

# Netzwerk
resource "docker_network" "net" {
  name = local.net_name
}

# Backend-Image aus 04-terraform-docker/backend
resource "docker_image" "backend" {
  name = local.backend_image
  build {
    context    = "${path.module}/backend"
    dockerfile = "Dockerfile"  # optional, Default heißt sowieso Dockerfile
  }
}

# Frontend-Image aus 04-terraform-docker/frontend
resource "docker_image" "frontend" {
  name = local.frontend_image
  build {
    context    = "${path.module}/frontend"
    dockerfile = "Dockerfile"
  }
}


# Backend-Container
resource "docker_container" "backend" {
  name  = local.backend_name
  image = docker_image.backend.image_id
  networks_advanced { name = docker_network.net.name }
  restart = "unless-stopped"
}

 

# Frontend-Container
resource "docker_container" "frontend" {
  name  = local.frontend_name
  image = docker_image.frontend.image_id
  networks_advanced { name = docker_network.net.name }
  depends_on = [docker_container.backend]
  restart    = "unless-stopped"

  dynamic "ports" {
    for_each = var.publish_frontend ? [1] : []
    content {
      internal = 80
      external = var.frontend_port
      protocol = "tcp"
    }
  }

  dynamic "healthcheck" {
    for_each = var.enable_healthchecks ? [1] : []
    content {
      test         = ["CMD-SHELL", "wget -qO- http://127.0.0.1/ >/dev/null || exit 1"]
      interval     = "10s"
      timeout      = "2s"
      retries      = 5
      start_period = "5s"
    }
  }
}
