#!/bin/sh

echo "Setting up control node configuration"

bash ./kubelet-config-file.sh
bash ./upgrade.sh
bash ./k3s-control-node-install.sh
bash ./helm-install.sh

echo "Copy k3s configuration file to Kubernets default directory"
mkdir $HOME/.kube
cp /etc/rancher/k3s/k3s.yaml $HOME/.kube/.

echo "Control node configuration set up."