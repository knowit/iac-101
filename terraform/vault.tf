module "vault" {
  source = "./webapp"
  name = "vault"
  image = "hashicorp/vault"
  port = 8200
  service_type = "LoadBalancer"
  env_variables = {
    "VAULT_DEV_LISTEN_ADDRESS" = "0.0.0.0:8200"
    "VAULT_DEV_ROOT_TOKEN_ID" = "myroot"
  }
}
