terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.14.0"
    }
    http = {
      source = "hashicorp/http"
      version = "3.1.0"
    }
    vault = {
      source = "hashicorp/vault"
      version = "3.9.1"
    }
  }
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
}

resource "kubernetes_namespace" "roma_namespace" {
  metadata {
    name = "roma"
  }
}