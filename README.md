# aks-nvme-ssd-provisioner
AKS NVMe disk provisioner to be used with the sig-storage-local-static-provisioner

Inspired by https://github.com/brunsgaard/eks-nvme-ssd-provisioner
and https://github.com/ams0/aks-nvme-ssd-provisioner




## Build of image

Build image, login to Azure and tag/push image
```
export version=0.0.7
podman build . -t aks-nvme-ssd-provisioner

./build/podman-login.sh dhiacrdev

podman tag localhost/aks-nvme-ssd-provisioner:latest dhiacrdev.azurecr.io/aks-nvme-ssd-provisioner:$version
podman push dhiacrdev.azurecr.io/aks-nvme-ssd-provisioner:$version
```
