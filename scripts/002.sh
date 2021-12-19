#!/bin/sh
set -x # echo all commands

# https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/high-availability/#steps-for-the-first-control-plane-node
# https://stackoverflow.com/questions/49553477/kubeadm-join-fails-with-connection-refused-on-one-node-only

# note: supply the control plane's address here --apiserver-advertise-address :(
echo "Create cluster..."
sudo kubeadm init --pod-network-cidr=192.168.57.0/21 --apiserver-advertise-address=192.168.56.10

echo "Configure account..."
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

echo "Apply CNI plug-in"
kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"
