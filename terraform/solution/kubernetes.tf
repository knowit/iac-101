provider "kubernetes" {
  config_path    = "~/.kube/config"
}

 resource "kubernetes_namespace" "roma_namespace" {
  metadata {
    name = "roma"
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
            value = "hahahaha"
          }
          port {
            container_port = 8080
          }

        }
      }
    }
  }
}
