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
nmcli con show

# Ask for the network interface name
echo "Please enter the network interface name for the fixed IP (e.g., eth0):"
read INTERFACE_NAME

# Set the static IP address
sudo nmcli con mod $INTERFACE_NAME ipv4.addresses $IP_ADDRESS/24

# Set the gateway
sudo nmcli con mod $INTERFACE_NAME ipv4.gateway $GATEWAY_ADDRESS

# Set the DNS server
sudo nmcli con mod $INTERFACE_NAME ipv4.dns $DNS_SERVER

# Set the connection to be automatically connected
sudo nmcli con mod $INTERFACE_NAME ipv4.method manual

# Bring the interface down and up to apply the changes
sudo nmcli con down $INTERFACE_NAME
sudo nmcli con up $INTERFACE_NAME

echo "Fixed IP address set up."