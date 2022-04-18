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


## Monitoring

This project uses the `istio` default monitoring tools:

- Prometheus, the open source monitoring system and time series database. You can use Prometheus with Istio to record metrics that track the health of Istio and of applications within the service mesh.

- Grafana, the open source monitoring solution that can be used to configure dashboards for Istio. You can use Grafana to monitor the health of Istio and of applications within the service mesh.

- Kiali, visualize different aspects of your Istio mesh, such as application wizards, detail views, health, istio configurations, multi-cluster deployments, etc.
## Service Mesh

- Secure cloud-native apps
- Manage traffic effectively
- Monitor service mesh
- Facilitates multiple deployment strategies
- Simplify load balancing with advanced features
- Enforce security
- End to end encryption with mTLS

![istio arch](./.media/service-mesh.png)

For this demo, [Booking](https://istio.io/latest/docs/examples/bookinfo/), the istio example, is used:
![booking](./.media/Booking.png)

## Usage

### Requirements

- A GCP Service Account file that will be used as a [GitHub Actions secret](https://docs.github.com/en/enterprise-server@3.4/actions/security-guides/encrypted-secrets) named `GKE_SA`, please [follow these guide](https://cloud.google.com/iam/docs/creating-managing-service-account-keys)
- The GCP `project id` you will deploy to. Currently, the project has this value hardcoded at [locals.tf](./infrastructure/env/dev/locals.tf). If you desire to have mo flexibility, you can create a `datasource` or use other method to provide the value such as a `TF_VAR`

### Access monitoring and gitops tools from local

#### Kiali
`kubectl port-forward svc/kiali -n istio-system 5000:20001`

#### Grafana
`kubectl port-forward svc/grafana -n istio-system 5001:3000`
Get token:
`kubectl get secret -n istio-system $(kubectl get sa kiali-service-account -n istio-system -o "jsonpath={.secrets[0].name}") -o jsonpath={.data.token} | base64 -d`

#### ArgoCD
`kubectl port-forward svc/argocd-server -n argocd 5002:443`
Get password:
`kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d`



TODO some day
