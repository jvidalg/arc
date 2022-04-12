

terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
    helm = {
      source = "hashicorp/helm"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
    random = {
      source = "hashicorp/random"
    }
    htpasswd = {
      source = "loafoe/htpasswd"
    }

  }

  backend "gcs" {
    bucket = "tf-state-arc-demo"
    prefix = "terraform/state"
  }
  required_version = ">= 0.13"
}
