data "vault_generic_secret" "the_joke" {
  path = "secret/joke"
  depends_on = [
    vault_generic_secret.joke
  ]
}

resource "kubernetes_deployment" "frontend" {
  metadata {
    name = "frontend"
    namespace = "roma"
    labels = {
      app = "frontend"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "frontend"
      }
    }

    template {
      metadata {
        labels = {
          app = "frontend"
        }
      }

      spec {
        container {
          image = "ghcr.io/kstigen/iac-101:latest"
          name  = "frontend"
          env {
            name = "JOKE"
            value = jsondecode(data.vault_generic_secret.the_joke.data_json).joke
          }
          port {
            container_port = 8080
          }

        }
      }
    }
  }
}

resource "kubernetes_service" "frontend_service" {
  metadata {
    name = "frontend-service"
    namespace = "roma"
  }
  spec {
    selector = {
      app = "frontend"
    }
    port {
      port        = 8080
      target_port = 8080
    }

    type = "LoadBalancer"
  }
}
