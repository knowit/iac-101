resource "kubernetes_deployment" "vault" {
  metadata {
    name = "vault"
    # TODO
  }

  spec {
    replicas = 1
    selector {
      # TODO
    }

    template {
      metadata {
        # TODO
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
  #TODO
  #Hvis ikke docker desktop - Bruk ClusterIP + port forwarding
}


