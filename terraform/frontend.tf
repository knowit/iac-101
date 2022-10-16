data "vault_generic_secret" "the_joke" {
  path = "secret/joke"
  depends_on = [
    vault_generic_secret.joke
  ]
}

module "frontend" {
  source = "./webapp"
  name = "frontend"
  image = "ghcr.io/kstigen/iac-101:latest"
  port = 8080
  service_type = "LoadBalancer"
  env_variables = {
    "JOKE" = jsondecode(data.vault_generic_secret.the_joke.data_json).joke
  }
}

