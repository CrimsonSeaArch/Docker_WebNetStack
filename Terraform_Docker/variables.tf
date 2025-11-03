variable "project" {
  description = "Präfix für Ressourcen (Netz, Container-Namen, Images)"
  type        = string
  default     = "webnetstack"
}

variable "frontend_port" {
  description = "Host-Port für das Frontend (NGINX)"
  type        = number
  default     = 8082
}

variable "backend_port" {
  description = "Interner Port für FastAPI"
  type        = number
  default     = 8000
}

variable "images" {
  description = "Image-Namen und Tags"
  type = object({
    frontend_name = string
    frontend_tag  = string
    backend_name  = string
    backend_tag   = string
  })
  default = {
    frontend_name = "webnetstack/frontend"
    frontend_tag  = "tf"
    backend_name  = "webnetstack/backend"
    backend_tag   = "tf"
  }
}

variable "build_contexts" {
  description = "Build-Kontexte relativ zu diesem Verzeichnis"
  type = object({
    frontend = string
    backend  = string
  })
  default = {
    frontend = "../03-frontend-backend-network/frontend"
    backend  = "../03-frontend-backend-network/backend"
  }
}

variable "publish_frontend" {
  description = "Ob der Frontend-Port nach außen gemappt werden soll"
  type        = bool
  default     = true
}

variable "enable_healthchecks" {
  description = "Healthchecks aktivieren oder deaktivieren"
  type        = bool
  default     = true
}
