resource "kubernetes_secret" "roma-secret" {
  metadata {
    name = "delete-this-secret"
    namespace = "roma"
  }

  data = {
    username = "roma"
    password = "IAC-101"
  }

  type = "kubernetes.io/basic-auth"
}