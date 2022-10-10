provider "kubernetes" {
  config_path    = "~/.kube/config"
}

 resource "kubernetes_namespace" "roma_namespace" {
  metadata {
    name = "roma"
  }
}

resource "kubernetes_ingress_v1" "roma_ingress" {
  metadata {
    name = "ingress"
    namespace = "roma"
  }

  spec {
    rule {
      http {
        path {
          backend {
            service {
              name = "vault-service"
              port {
                number = 8200
              }
            }
          }
          path = "/"
        }
      }
    }
  }
}

resource "kubernetes_service_v1" "vault_service" {
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

    type = "ClusterIP"
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

resource "kubernetes_deployment" "caddy" {
  metadata {
    name = "caddy"
    namespace = "roma"
    labels = {
      test = "caddy"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        test = "caddy"
      }
    }

    template {
      metadata {
        labels = {
          test = "caddy"
        }
      }

      spec {
        container {
          image = "nginx:1.21.6"
          name  = "caddy"

        }
      }
    }
  }
}
