# GKE Demo

## Status
| Branch  | Status  |
|---|---|
| `main`   | [![Terraform main](https://github.com/jvidalg/arc/workflows/Terraform%20main/badge.svg?branch=main)](https://github.com/jvidalg/arc/actions/workflows/main.yml)  |
| `develop`  | [![Terraform develop](https://github.com/jvidalg/arc/workflows/Terraform%20develop/badge.svg?branch=develop)](https://github.com/jvidalg/arc/actions/workflows/develop.yml)  |

## Infrastructure

![gke layout](./.media/GKEGCPKubernetesGKE.png)

Regional cluster

- Control and Data plane High Availability
- Resilence from zone failure
- Continuous control plane upgrades
- Reduced downtime from control plane failures

## CICD

### Terraform

![cicd](./.media/workflow.png)

### Applications

Argocd is used for applications deployments to the GKE cluster. For this demo, we are using the raw kubernetes manifest files, but Argocd also supports other methods such as helm.

#### GitOps

![argo](./.media/Argo.png)

## Service Mesh

- Secure cloud-native apps
- Manage traffic effectively
- Monitor service mesh
- Simplify load balancing with advanced features
- Enforce security
- End to end encryption

![istio arch](./.media/service-mesh.png)

For this demo, [Booking](https://istio.io/latest/docs/examples/bookinfo/), the istio example, is used:
![booking](./.media/Booking.png)

## Usage

### Requirements

- A GCP service account file that will be used as a GitHub Actions secret named `GKE_SA`, please ![follow these guide](https://cloud.google.com/iam/docs/creating-managing-service-account-keys)
- The GCP `project id` you will deploy to. Currently, the project has this value hardcoded at ![locals.tf](./infrastructure/env/dev/locals.tf). If you desire to have mo flexibility, you can create a `datasource` or use other method to provide the value such as a `TF_VAR`


TODO some day

