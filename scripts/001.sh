#!/bin/sh
set -x # echo all commands

# https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/

echo "Disable swap..."
sudo swapoff -a

echo "Verify MAC address are unique..."
ip link

echo "Make sure that the br_netfilter module is loaded..."
sudo modprobe br_netfilter
lsmod | grep br_netfilter

echo "Update the apt package index and install packages needed to use the Kubernetes apt repository..."
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl

echo "Download the Google Cloud public signing key..."
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg

echo "Add the Kubernetes apt repository..."
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

# spcify an older version for upgrading purposes
echo "Update apt package index, install docker kubelet, kubeadm and kubectl, and pin their version..."
sudo apt-get update
sudo apt-get install -y docker.io kubelet=1.22.5-00 kubeadm=1.22.5-00 kubectl=1.22.5-00
sudo apt-mark hold docker.io kubelet kubeadm kubectl

echo "Start service..."
sudo systemctl enable kubelet.service
sudo systemctl enable docker.service

echo "Clean-up..."
sudo apt-get autoclean -y
sudo apt-get autoremove -y

alias k=kubectl
alias ka=kubeadm
