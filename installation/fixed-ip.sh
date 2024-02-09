#!/bin/sh

echo "Setting up fixed IP address"

# Ask for the IP address
echo "Please enter the IP address:"
read IP_ADDRESS

# Get the network interfaces
echo "Network interfaces:"
nmcli con show

# Ask for the network interface name
echo "Please enter the network interface name (e.g., eth0):"
read INTERFACE_NAME

# Set the static IP address
sudo nmcli con mod $INTERFACE_NAME ipv4.addresses $IP_ADDRESS/24 ipv4.method manual

# Bring the interface down and up to apply the changes
sudo nmcli con down $INTERFACE_NAME
sudo nmcli con up $INTERFACE_NAME

echo "Fixed IP address set up."