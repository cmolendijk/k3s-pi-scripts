#!/bin/sh

echo "Setting up fixed IP address for eth0"

# Get current network configuration as backup
CURRENT_IP=$(ip addr show eth0 | grep "inet " | awk '{print $2}')
CURRENT_GATEWAY=$(ip route show default | awk '{print $3}')

echo "Current IP: $CURRENT_IP"
echo "Current Gateway: $CURRENT_GATEWAY"

# Ask for the IP address
echo "Please enter the IP address with subnet mask (e.g., 192.168.1.100/24):"
read IP_ADDRESS

# Ask for the gateway address
echo "Please enter the default gateway:"
read GATEWAY_ADDRESS

# Backup existing netplan configuration
sudo cp /etc/netplan/00-installer-config.yaml /etc/netplan/00-installer-config.yaml.backup 2>/dev/null || true

# Create new netplan configuration
sudo tee /etc/netplan/00-installer-config.yaml << EOF
network:
  ethernets:
    eth0:
      dhcp4: false
      addresses:
        - $IP_ADDRESS
      routes:
        - to: 0.0.0.0/0
          via: $GATEWAY_ADDRESS
      nameservers:
        addresses: [1.1.1.1, 8.8.8.8]
  version: 2
EOF

# Apply the netplan configuration
sudo netplan apply

# Fix potential DNS issues
sudo systemctl restart systemd-resolved.service

# Ensure DNS resolution works by updating resolv.conf
sudo rm /etc/resolv.conf 2>/dev/null || true
sudo touch /etc/resolv.conf
echo "nameserver 1.1.1.1" | sudo tee -a /etc/resolv.conf
echo "nameserver 8.8.8.8" | sudo tee -a /etc/resolv.conf

echo "Fixed IP address has been set up for eth0. Please verify the connection."
echo "New configuration:"
ip addr show eth0 | grep "inet "