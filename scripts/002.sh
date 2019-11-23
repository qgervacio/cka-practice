#!/bin/sh
set -x # echo all commands

echo "Get files for pod network..."
wget https://docs.projectcalico.org/v3.3/getting-started/kubernetes/installation/hosted/rbac-kdd.yaml
wget https://docs.projectcalico.org/v3.3/getting-started/kubernetes/installation/hosted/kubernetes-datastore/calico-networking/1.7/calico.yaml

echo "Create cluster, specify pod network that matches calico.yaml..."
cat calico.yaml | grep 192.168.0.0/16

# idk sometimes this throws conn timeout. just re-run if that happened
sudo kubeadm init --pod-network-cidr=192.168.0.0/16

echo "Configure account..."
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

echo "Deploy downloaded YAMLs..."
kubectl apply -f rbac-kdd.yaml
kubectl apply -f calico.yaml
