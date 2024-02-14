echo "Getting ready to install k3s on a Raspberry Pi"

sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install git -y
mkdir -p $HOME/repos
git clone https://github.com/cmolendijk/k3s-pi-scripts.git $HOME/repos/k3s-pi-scripts

echo "Done getting ready to install k3s on a Raspberry Pi."