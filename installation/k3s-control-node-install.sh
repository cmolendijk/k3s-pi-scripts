#!/bin/sh

echo "Installing k3s control node"
TOKEN=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
curl -sfL https://get.k3s.io | K3S_TOKEN=$TOKEN sh -s --node-label 'node_type=controller'
echo "K3s control node installed with token: $TOKEN"