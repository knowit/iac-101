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

resource "vault_generic_secret" "joke" {
  path = "secret/joke"

  data_json = jsonencode(
    {
      "joke"   = jsondecode(data.http.chuck.response_body).value,
    }
  )
}
