resource "kubernetes_deployment_v1" "kong_ui" {
  metadata {
    name      = "kong-ui"
    namespace = var.namespace
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "kong-ui"
      }
    }

    template {
      metadata {
        labels = {
          app = "kong-ui"
        }
      }

      spec {
        container {
          name  = "kong-ui"
          image = "node:20-alpine"

          command = ["sh", "-c"]
          args = [
            <<EOF
            npx create-next-app@latest kong-ui --ts --app --tailwind --eslint &&
            cd kong-ui &&
            npm install axios &&
            npm run dev
            EOF
          ]

          env {
            name  = "KONG_ADMIN_URL"
            value = var.kong_admin_url
          }

          port {
            container_port = 3000
          }
        }
      }
    }
  }
}

variable "namespace" {
  type    = string
  default = "kong"
}

variable "kong_admin_url" {
  type    = string
  default = "http://kong-kong-admin:8001"
}




