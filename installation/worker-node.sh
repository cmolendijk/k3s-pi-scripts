#!/bin/sh

echo "Setting up control node configuration"

kubelet-config-file.sh
upgrade.sh
k3s-worker-node-install.sh
helm-install.sh

echo "Copy k3s configuration file to Kubernets default directory"
mkdir $HOME/.kube
cp /etc/rancher/k3s/k3s.yaml $HOME/.kube/.

echo "Control node configuration set up."