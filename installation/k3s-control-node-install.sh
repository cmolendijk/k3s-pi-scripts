#!/bin/sh

echo "Installing k3s control node"
TOKEN=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
curl -sfL https://get.k3s.io | K3S_TOKEN=$TOKEN sh -s - server --write-kubeconfig-mode '0644' --node-taint 'node-role.kubernetes.io/master=true:NoSchedule' --kubelet-arg 'config=/etc/rancher/k3s/kubelet.config' --kube-controller-manager-arg 'terminated-pod-gc-threshold=10'
echo "K3s control node installed with token: $TOKEN"