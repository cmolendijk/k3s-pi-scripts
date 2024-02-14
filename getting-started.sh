echo "Getting ready to install k3s on a Raspberry Pi"

apt-get update && apt-get upgrade -y
apt-get install git -y
mkdir -p $HOME/repos
git clone https://github.com/cmolendijk/k3s-pi-scripts.git $HOME/repos/k3s-pi-scripts

echo "Done getting ready to install k3s on a Raspberry Pi."