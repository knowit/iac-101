terraform {
  required_providers {
    vault = {
      source = "hashicorp/vault"
      version = "3.9.1"
    }
  }
}

#   provider "vault" {
#     address = "http://localhost:8200"
#     token = "myroot"
#     skip_tls_verify = true
#     skip_child_token = true
#   }

#   resource "vault_generic_secret" "example" {
#     path = "secret/foo"

#     data_json = jsonencode(
#       {
#         "foo"   = "bar",
#         "pizza" = "cheese"
#       }
#     )
#   }
