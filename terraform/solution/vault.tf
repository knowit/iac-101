resource "kubernetes_deployment" "vault" {
  metadata {
    name = "vault"
    namespace = "roma"
    labels = {
      app = "vault"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "vault"
      }
    }

    template {
      metadata {
        labels = {
          app = "vault"
        }
      }

      spec {
        container {
          image = "hashicorp/vault"
          name  = "vault"
          env {
            name  = "VAULT_DEV_LISTEN_ADDRESS"
            value = "0.0.0.0:8200"
          }
          env {
            name = "VAULT_DEV_ROOT_TOKEN_ID"
            value = "myroot"
          }
          port {
            container_port = 8200
            host_port = 8200
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "vault_service" {
  metadata {
    name = "vault-service"
    namespace = "roma"
  }
  spec {
    selector = {
      app = "vault"
    }
    session_affinity = "ClientIP"
    port {
      port        = 8200
      target_port = 8200
    }

    type = "LoadBalancer"
  }
}


