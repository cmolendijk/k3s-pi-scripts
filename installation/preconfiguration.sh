#!/bin/sh

# Upgrade the system
bash $HOME/repos/k3s-pi-scripts/installation/upgrade.sh

echo "Setting up preconfiguration"

# Enable iptables to see bridged traffic
sudo tee /etc/modules-load.d/k8s.conf <<EOF
br_netfilter
EOF
sudo tee /etc/sysctl.d/k8s.conf <<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sudo sysctl --system

#Enable cgroup on Raspberry PI nodes.
echo "cgroup_enable=cpuset cgroup_memory=1 cgroup_enable=memory" | sudo tee -a /boot/firmware/cmdline.txt
echo "Preconfiguration set up."

# set the static IP address
bash $HOME/repos/k3s-pi-scripts/installation/fixed-ip.sh

# Reboot the system
sudo reboot