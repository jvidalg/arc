locals {
  domain = "test"

  argocd_values_file = templatefile(
    "${path.module}/templates/argocd.yaml.tpl",
    {
      "values" : merge(var.argocd_tpl_values)
    }
  )
  istio_base_values_file = templatefile(
    "${path.module}/templates/istio-base.yaml.tpl",
    {
      "values" : merge(var.istio_base_tpl_values)
    }
  )
  istiod_values_file = templatefile(
    "${path.module}/templates/istiod.yaml.tpl",
    {
      "values" : merge(var.istiod_tpl_values)
    }
  )
  istio_ingress_values_file = templatefile(
    "${path.module}/templates/istio-ingress.yaml.tpl",
    {
      "values" : merge(var.istio_ingress_tpl_values)
    }
  )
  kiali_values_file = templatefile(
    "${path.module}/templates/kiali-operator.yaml.tpl",
    {
      "values" : merge(var.kiali_operator_tpl_values)
    }
  )
}

provider "kubernetes" {
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}

provider "helm" {
  kubernetes {
    host                   = "https://${module.gke.endpoint}"
    token                  = data.google_client_config.default.access_token
    cluster_ca_certificate = base64decode(module.gke.ca_certificate)
  }
}

resource "kubernetes_namespace" "namespace" {
  depends_on = [
    module.gke
  ]
  for_each = {
    for ns in var.namespaces : ns => {}
  }
  metadata {
    name = each.key
  }
}

resource "kubernetes_namespace" "istio-ingress" {
  depends_on = [
    module.gke
  ]
  metadata {
    annotations = {
      name = "istio-gateway"
    }
    # labels = {
    #   istio-injection = "enabled"
    # }
    name = "istio-ingress"
  }
}

resource "helm_release" "argocd" {
  depends_on = [
    kubernetes_namespace.namespace
  ]
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "3.35.4"
  values = [
    local.argocd_values_file,
  ]
  namespace = var.namespaces[1]
  timeout   = 1200
}

resource "helm_release" "istio-base" {
  depends_on = [
    kubernetes_namespace.namespace
  ]
  name       = "istio-base"
  repository = "https://istio-release.storage.googleapis.com/charts"
  chart      = "base"
  version    = "1.13.2"
  values = [
    local.istio_base_values_file
  ]
  namespace = var.namespaces[2]
  timeout   = 1200
}

resource "helm_release" "istiod" {
  depends_on = [
    kubernetes_namespace.namespace
  ]
  name       = "istiod"
  repository = "https://istio-release.storage.googleapis.com/charts"
  chart      = "istiod"
  version    = "1.13.2"
  values = [
    local.istiod_values_file
  ]
  namespace = var.namespaces[2]
  timeout   = 1200
}

resource "helm_release" "istio-ingress" {
  depends_on = [
    kubernetes_namespace.namespace, resource.kubernetes_namespace.istio-ingress
  ]
  name       = "istio-ingress"
  repository = "https://istio-release.storage.googleapis.com/charts"
  chart      = "gateway"
  version    = "1.13.2"
  values = [
    local.istio_ingress_values_file
  ]
  namespace = "istio-ingress"
  timeout   = 1200
  lifecycle {
    ignore_changes = [metadata, values]
  }
}

resource "helm_release" "kiali-operator" {
  depends_on = [
    kubernetes_namespace.namespace, resource.kubernetes_namespace.istio-ingress
  ]
  name       = "kiali-operator"
  repository = "https://kiali.org/helm-charts"
  chart      = "kiali-operator"
  version    = "v1.49.0"
  values = [
    local.kiali_values_file
  ]
  namespace = var.namespaces[3]
  timeout   = 1200
}
