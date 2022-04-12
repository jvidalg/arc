module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~> 4.0"

  project_id   = local.project_id
  network_name = "arc-poc"
  routing_mode = "GLOBAL"

  subnets = [
    {
      subnet_name           = "subnet-01"
      subnet_ip             = "10.10.32.0/20"
      subnet_region         = "us-west1"
      subnet_private_access = "true"
    },
    {
      subnet_name           = "subnet-02"
      subnet_ip             = "10.10.64.0/20"
      subnet_region         = "us-west1"
      subnet_private_access = "true"
      subnet_flow_logs      = "true"
      description           = "Subnet02"
    },
    {
      subnet_name           = "subnet-03"
      subnet_ip             = "10.10.96.0/20"
      subnet_region         = "us-west1"
      subnet_private_access = "true"
      subnet_flow_logs      = "true"
    }
  ]

  secondary_ranges = {
    subnet-01 = [
      {
        range_name    = "services-range"
        ip_cidr_range = "192.168.0.0/22"
      },
      {
        range_name    = "pods-range"
        ip_cidr_range = "192.168.64.0/22"
      },
    ]
    subnet-02 = [
      {
        range_name    = "services-range"
        ip_cidr_range = "192.168.96.0/22"
      },
      {
        range_name    = "pods-range"
        ip_cidr_range = "192.168.124.0/22"
      },
    ]
    subnet-03 = [
      {
        range_name    = "services-range"
        ip_cidr_range = "192.168.164.0/22"
      },
      {
        range_name    = "pods-range"
        ip_cidr_range = "192.168.196.0/22"
      },
    ]
  }

  routes = [
    {
      name              = "egress-internet"
      description       = "route through IGW to access internet"
      destination_range = "0.0.0.0/0"
      tags              = "egress-inet"
      next_hop_internet = "true"
    }
    # ,
    # {
    #   name                   = "app-proxy"
    #   description            = "route through proxy to reach app"
    #   destination_range      = "10.50.10.0/24"
    #   tags                   = "app-proxy"
    #   next_hop_instance      = "app-proxy-instance"
    #   next_hop_instance_zone = "us-west1-a"
    # },
  ]
}

