# provider "argocd" {
#   server_addr = "argocd-server.argocd.svc.cluster.local:443"
#   username = "admin"
#   password = ""
# }

# resource "argocd_application" "sleep" {

#   metadata {
#     name      = "sleep-app"
#     namespace = "apps"
#     labels = {
#       demo = "true"
#     }
#   }

#   spec {
#     project = "sleep"

#     source {
#       repo_url        = "https://github.com/jvidalg/arc"
#       path            = "apps/sleep"
#       target_revision = "main"
#       directory {

#       }
#     }
#   }

#   destination {
#     server    = "https://kubernetes.default.svc"
#     namespace = "apps"
#   }

#   sync_policy {
#     automated = {
#       prune       = true
#       self_heal   = true
#       allow_empty = true
#     }
#     # Only available from ArgoCD 1.5.0 onwards
#     sync_options = ["Validate=false"]
#     retry {
#       limit = "5"
#       backoff = {
#         duration     = "30s"
#         max_duration = "2m"
#         factor       = "2"
#       }
#     }
#   }
# }
