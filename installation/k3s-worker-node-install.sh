#!/bin/sh

echo "Setting up worker node configuration"

# Ask for the server token
echo "Please enter the server token:"
read SERVER_TOKEN

# Ask for the K3S master IP
echo "Please enter the K3S master IP:"
read K3S_MASTER_IP

# Execute the curl command with the provided values
curl -sfL https://get.k3s.io | K3S_URL="https://$K3S_MASTER_IP:6443" K3S_TOKEN=$SERVER_TOKEN sh -s - --node-label 'node_type=worker' --kubelet-arg 'config=/etc/rancher/k3s/kubelet.config' --kube-proxy-arg 'metrics-bind-address=0.0.0.0'

echo "Worker node configuration set up."