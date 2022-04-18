

variable "gpc_project_name" {
  default = "arc-demo"
}

variable "region" {
  type    = string
  default = "us-west1"
}

### GKE ###

variable "cluster_name" {
  type    = string
  default = "arc-demo"
}


variable "namespaces" {
  default = [
    "shared-services", "argocd", "istio-system", "kiali-operator"
  ]
}

variable "argocd_tpl_values" {
  default = {}
}

variable "istio_base_tpl_values" {
  default = {}
}

variable "istiod_tpl_values" {
  default = {}
}

variable "istio_ingress_tpl_values" {
  default = {}
}

variable "kiali_operator_tpl_values" {
  default = {}
}

variable "cert_manager_tpl_values" {
  default = {}
}
