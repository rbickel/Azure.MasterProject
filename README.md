# Azure.MasterProject
Master Azure project used to experiment various technologies. Terraform, K8S, Helm, KEDA, DAPR, and more...


## Infrastructure provisioning

Infrastrucutre provisionning and state management with Terraform

[![Infrastructure deployment](https://github.com/rbickel/Azure.MasterProject/actions/workflows/infrastructure-provisioning.yml/badge.svg)](https://github.com/rbickel/Azure.MasterProject/actions/workflows/infrastructure-provisioning.yml)

## Kubeapi reverse proxy

Layer 4 reverse proxy to access the kubeapi through private link

[![Helm publish](https://github.com/rbickel/AKS.MasterProject/actions/workflows/kubeapi-reverseproxy-chart-publish.yml/badge.svg)](https://github.com/rbickel/AKS.MasterProject/actions/workflows/kubeapi-reverseproxy-chart-publish.yml)


## Payment API

AspNet 5 WebAPI REST API.

[![Docker build](https://github.com/rbickel/AKS.MasterProject/actions/workflows/paymentapi-docker-build-and-publish.yml/badge.svg)](https://github.com/rbickel/AKS.MasterProject/actions/workflows/paymentapi-docker-build-and-publish.yml)

[![Helm publish](https://github.com/rbickel/AKS.MasterProject/actions/workflows/paymentapi-chart-publish.yml/badge.svg)](https://github.com/rbickel/AKS.MasterProject/actions/workflows/paymentapi-chart-publish.yml)

## Secure Token Provider

Azure function to exchange credit card details for a token to be used for payments. Credit card details are stored securely in a separate PCI-DSS compliant backend

[![Docker build](https://github.com/rbickel/AKS.MasterProject/actions/workflows/securetokenprovider-docker-build-and-publish.yml/badge.svg)](https://github.com/rbickel/AKS.MasterProject/actions/workflows/securetokenprovider-docker-build-and-publish.yml)

## SFTP

[SFTP README](./Application/sftp/README.md)


[![Docker build](https://github.com/rbickel/AKS.MasterProject/actions/workflows/sftp-docker-build-and-publish.yml/badge.svg)](https://github.com/rbickel/AKS.MasterProject/actions/workflows/sftp-docker-build-and-publish.yml)

[![Helm publish](https://github.com/rbickel/AKS.MasterProject/actions/workflows/sftp-chart-publish.yml/badge.svg)](https://github.com/rbickel/AKS.MasterProject/actions/workflows/sftp-chart-publish.yml)