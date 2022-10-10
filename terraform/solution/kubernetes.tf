provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "my-context"
}

 resource "kubernetes_namespace" "roma_namespace" {
  metadata {
    name = "roma"
  }
}

resource "kubernetes_ingress_class" "example" {
  metadata {
    name = "example"
    namespace = "roma"
  }

  spec {
    controller = "example.com/ingress-controller"
    parameters {
      api_group = "k8s.example.com"
      kind      = "IngressParameters"
      name      = "external-lb"
    }
  }
}

resource "kubernetes_deployment" "caddy" {
  metadata {
    name = "caddy"
    namespace = "roma"
    labels = {
      test = "MyExampleApp"
    }
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        test = "MyExampleApp"
      }
    }

    template {
      metadata {
        labels = {
          test = "MyExampleApp"
        }
      }

      spec {
        container {
          image = "nginx:1.21.6"
          name  = "example"

        }
      }
    }
  }
}

resource "kubernetes_deployment" "vault" {
  metadata {
    name = "vault"
    namespace = "roma"
    labels = {
      test = "vault"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        test = "Vault"
      }
    }

    template {
      metadata {
        labels = {
          test = "Vault"
        }
      }

      spec {
        container {
          image = "hashicorp/vault"
          name  = "vault"
          env {
            name  = "VAULT_DEV_LISTEN_ADDRESS"
            value = "0.0.0.0:1234"
          }
          env {
            name = "VAULT_DEV_ROOT_TOKEN_ID"
            value = "myroot"
          }
          port {
            container_port = 8200:1234
          }
        }
      }
    }
  }
}
