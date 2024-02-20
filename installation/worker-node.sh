#!/bin/sh

echo "Setting up control node configuration"

bash $HOME/repos/k3s-pi-scripts/installation/kubelet-config-file.sh
bash $HOME/repos/k3s-pi-scripts/installation/upgrade.sh
bash $HOME/repos/k3s-pi-scripts/installation/k3s-worker-node-install.sh

echo "Control node configuration set up."