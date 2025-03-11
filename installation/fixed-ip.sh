#!/bin/sh

echo "Setting up fixed IP address"

# Show available network interfaces
echo "Available network interfaces:"
ip -br link show | grep -v "lo" | awk '{print $1}'

# Ask which interface to configure
echo -n "Enter the network interface to configure (e.g., wlan0, eth0): "
read INTERFACE

# Validate interface exists
if ! ip link show "$INTERFACE" >/dev/null 2>&1; then
    echo "Error: Interface $INTERFACE does not exist"
    exit 1
fi

# Get current network configuration as backup
CURRENT_IP=$(ip addr show $INTERFACE | grep "inet " | awk '{print $2}')
CURRENT_GATEWAY=$(ip route show default | awk '{print $3}')

echo "Current configuration for $INTERFACE:"
echo "IP: $CURRENT_IP"
echo "Gateway: $CURRENT_GATEWAY"

# Ask for the IP address
echo "Please enter the IP address with subnet mask (e.g., 192.168.1.100/24):"
read IP_ADDRESS

# Ask for the gateway address
echo "Please enter the default gateway:"
read GATEWAY_ADDRESS

# For wireless interfaces, we need the SSID and password
if [[ "$INTERFACE" == wlan* ]]; then
    echo "Wireless interface detected."
    echo "Please enter the WiFi SSID:"
    read WIFI_SSID
    echo "Please enter the WiFi password:"
    read -s WIFI_PASSWORD
fi

# Backup existing netplan configuration
sudo cp /etc/netplan/00-installer-config.yaml /etc/netplan/00-installer-config.yaml.backup 2>/dev/null || true

# Remove any existing netplan configurations to avoid conflicts
sudo rm -f /etc/netplan/01-netcfg.yaml
sudo rm -f /etc/netplan/00-installer-config.yaml
sudo rm -f /etc/netplan/50-cloud-init.yaml

# Create new netplan configuration with proper permissions
if [[ "$INTERFACE" == wlan* ]]; then
    # Configuration for wireless interface
    sudo tee /etc/netplan/00-installer-config.yaml << EOF
network:
  version: 2
  wifis:
    $INTERFACE:
      dhcp4: false
      addresses:
        - $IP_ADDRESS
      routes:
        - to: default
          via: $GATEWAY_ADDRESS
      nameservers:
        addresses: [1.1.1.1, 8.8.8.8]
      access-points:
        "$WIFI_SSID":
          password: "$WIFI_PASSWORD"
EOF
else
    # Configuration for ethernet interface
    sudo tee /etc/netplan/00-installer-config.yaml << EOF
network:
  version: 2
  ethernets:
    $INTERFACE:
      dhcp4: false
      addresses:
        - $IP_ADDRESS
      routes:
        - to: default
          via: $GATEWAY_ADDRESS
      nameservers:
        addresses: [1.1.1.1, 8.8.8.8]
EOF
fi

# Set correct permissions for netplan configuration
sudo chmod 600 /etc/netplan/00-installer-config.yaml

# Apply the netplan configuration
sudo netplan --debug generate
sudo netplan apply

# Fix potential DNS issues
sudo systemctl restart systemd-resolved.service

# Ensure DNS resolution works by updating resolv.conf
sudo rm -f /etc/resolv.conf
sudo touch /etc/resolv.conf
sudo chmod 644 /etc/resolv.conf
echo "nameserver 1.1.1.1" | sudo tee /etc/resolv.conf
echo "nameserver 8.8.8.8" | sudo tee -a /etc/resolv.conf

echo "Fixed IP address has been set up for $INTERFACE. Please verify the connection."
echo "New configuration:"
ip addr show $INTERFACE | grep "inet "