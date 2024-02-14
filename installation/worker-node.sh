#!/bin/sh

echo "Setting up control node configuration"

bash $HOME/repos/k3s-pi-scripts/kubelet-config-file.sh
bash $HOME/repos/k3s-pi-scripts/upgrade.sh
bash $HOME/repos/k3s-pi-scripts/k3s-worker-node-install.sh
bash $HOME/repos/k3s-pi-scripts/helm-install.sh

echo "Copy k3s configuration file to Kubernets default directory"
mkdir $HOME/.kube
cp /etc/rancher/k3s/k3s.yaml $HOME/.kube/.

echo "Control node configuration set up."