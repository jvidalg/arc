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



### Applications



#### GitOps

![argo](./.media/Argo.png)

## Service Mesh

For this demo, [Booking](https://istio.io/latest/docs/examples/bookinfo/), the istio example, is used:
![booking](./.media/Booking.png)
