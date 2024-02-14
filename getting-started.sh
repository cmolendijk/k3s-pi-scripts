echo "Getting ready to install k3s on a Raspberry Pi"

./installation/upgrade.sh
apt-get install git -y
mkdir $HOME/repos
cd $HOME/repos
git clone https://github.com/cmolendijk/k3s-pi-scripts.git

echo "Done getting ready to install k3s on a Raspberry Pi."