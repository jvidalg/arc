# google_client_config and kubernetes provider must be explicitly specified like the following.
data "google_client_config" "default" {}

resource "google_service_account" "default" {
  depends_on = [
    google_project_service.compute,
    google_project_service.container,
  ]
  project      = local.project_id
  account_id   = "service-account-id"
  display_name = "Service Account"
}

module "gke" {
  version    = "~> 20.0.0"
  source     = "terraform-google-modules/kubernetes-engine/google"
  project_id = local.project_id
  name       = var.cluster_name
  region     = var.region
  zones      = ["us-west1-a", "us-west1-b", "us-west1-c"]
  network    = module.vpc.network_name
  #subnetwork                 = module.vpc.subnets_ids[0]
  subnetwork                 = "subnet-01"
  ip_range_pods              = "pods-range"
  ip_range_services          = "services-range"
  http_load_balancing        = false
  network_policy             = false
  horizontal_pod_autoscaling = true
  filestore_csi_driver       = false
  default_max_pods_per_node  = 55

  node_pools = [
    {
      name               = "arc-node-pool"
      machine_type       = "e2-medium"
      node_locations     = "us-west1-a,us-west1-b,us-west1-c"
      min_count          = 1
      max_count          = 3
      local_ssd_count    = 0
      disk_size_gb       = 100
      disk_type          = "pd-standard"
      image_type         = "COS_CONTAINERD"
      auto_repair        = true
      auto_upgrade       = true
      service_account    = google_service_account.default.email
      preemptible        = false
      initial_node_count = 2
    },
  ]

  node_pools_tags = {
    all = []

    default-node-pool = [
      "default-node-pool",
    ]
  }
  depends_on = [
    module.vpc
  ]
}

output "subnet1" {
  value = module.vpc.subnets_ids[0]
}