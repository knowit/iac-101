data "vault_generic_secret" "the_joke" {
  path = "secret/joke"
  depends_on = [
    vault_generic_secret.joke
  ]
}

resource "kubernetes_deployment" "webapp" {
  metadata {
    name = "webapp"
    namespace = "roma"
    labels = {
      app = "webapp"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "webapp"
      }
    }

    template {
      metadata {
        labels = {
          app = "webapp"
        }
      }

      spec {
        container {
          image = "ghcr.io/kstigen/iac-101:0.0.2"
          name  = "webapp"
          env {
            name = "JOKE"
            value = data.vault_generic_secret.the_joke.data_json
          }
          port {
            container_port = 8080
          }

        }
      }
    }
  }
}

resource "kubernetes_service" "webapp_service" {
  metadata {
    name = "webapp-service"
    namespace = "roma"
  }
  spec {
    selector = {
      app = "webapp"
    }
    port {
      port        = 8080
      target_port = 8080
    }

    type = "LoadBalancer"
  }
}
