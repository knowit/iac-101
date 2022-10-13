terraform {
  required_providers {
    vault = {
      source = "hashicorp/vault"
      version = "3.9.1"
    }
    http = {
      source = "hashicorp/http"
      version = "3.1.0"
    }
  }
}

provider "http" {}

provider "vault" {
  address = "http://localhost:8200"
  token = "myroot"
  skip_tls_verify = true
  skip_child_token = true
}

data "http" "chuck" {
  url = "https://api.chucknorris.io/jokes/random"
  request_headers = {
    Accept = "application/json"
  }
}

resource "vault_generic_secret" "example" {
  path = "secret/joke"

  data_json = jsonencode(
    {
      "joke"   = jsondecode(data.http.chuck.response_body).value,
    }
  )
}
