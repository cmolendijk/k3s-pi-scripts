#!/bin/sh

#Prepare K3S kubelet configuration file
echo "Preparing K3S kubelet configuration file"

sudo mkdir -p /etc/rancher/k3s

sudo tee /etc/rancher/k3s/kubelet.config <<EOF
apiVersion: kubelet.config.k8s.io/v1beta1
kind: KubeletConfiguration
shutdownGracePeriod: 30s
shutdownGracePeriodCriticalPods: 10s
EOF

echo "K3S kubelet configuration file prepared."