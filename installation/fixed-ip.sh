#!/bin/sh

echo "Setting up fixed IP address"

# Ask for the IP address
echo "Please enter the IP address:"
read IP_ADDRESS

# Ask for the gateway address
echo "Please enter the default gateway:"
read GATEWAY_ADDRESS

# Ask for the DNS server
echo "Please enter the DNS server:"
read DNS_SERVER

# Get the network interfaces
echo "Available network interfaces:"
ip link show

# Ask for the network interface name
echo "Please enter the network interface name for the fixed IP (e.g., eth0):"
read INTERFACE_NAME

# Create netplan configuration
sudo tee /etc/netplan/01-netcfg.yaml << EOF
network:
  version: 2
  renderer: networkd
  ethernets:
    $INTERFACE_NAME:
      dhcp4: no
      addresses:
        - $IP_ADDRESS/24
      gateway4: $GATEWAY_ADDRESS
      nameservers:
        addresses: [$DNS_SERVER]
EOF

# Apply the netplan configuration
sudo netplan apply

echo "Fixed IP address set up using netplan. Please verify the connection."