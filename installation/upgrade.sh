#!/bin/sh

echo "Upgrading system..."
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get autoremove
sudo apt-get autoclean
echo "System upgraded."