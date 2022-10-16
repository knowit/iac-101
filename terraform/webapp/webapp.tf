resource "kubernetes_deployment" "webapp" {
  metadata {
    name = var.name
    namespace = var.namespace
    labels = {
      app = var.name
    }
  }

  spec {
    replicas = var.replicas

    selector {
      match_labels = {
        app = var.name
      }
    }

    template {
      metadata {
        labels = {
          app = var.name
        }
      }

      spec {
        container {
          image = var.image
          name  = var.name
          
          dynamic "env" {
            for_each = var.env_variables
            content {
                name = env.key
                value = env.value
            }
          }

          port {
            container_port = var.port
          }

        }
      }
    }
  }
}

resource "kubernetes_service" "webapp_service" {
  metadata {
    name = "${var.name}-service"
    namespace = var.namespace
  }
  spec {
    selector = {
      app = var.name
    }
    port {
      port        = var.port
      target_port = var.port
    }

    type = var.service_type
  }
}
