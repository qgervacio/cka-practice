#!/bin/sh
set -x # echo all commands

echo "Disable swap..."
swapoff -a

echo "Add google repo gpg key..."
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

echo "Add kube apt repos..."
sudo bash -c 'cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
'

echo "Update and install docker and kube..."
sudo apt-get update
sudo apt-get install -y docker.io kubelet kubeadm kubectl

echo "Hold to prevent update..."
sudo apt-mark hold docker.io kubelet kubeadm kubectl

echo "Start service..."
sudo systemctl enable kubelet.service
sudo systemctl enable docker.service
