# k3S cluster on Raspberry PI
In this repo I share my hobby project where I install an K3S cluster on 5 raspberry pi 4B devices. The scripts are made for specific purpose but I try to make it more and more configurable where possible.

## Getting started
First we need to prepare our Raspberry Pi cards with a bootable. I use the [Raspberry PI Imager](https://www.raspberrypi.com/news/raspberry-pi-imager-imaging-utility/) for this and uses the following settings:
 - **Raspberry Pi Model:** RASPBERRY PI 4
 - **Opperating system:** RASPBERRY PI OS LITE (64-BIT)
 - **Storage device:** The devices that has my SD card

In the next step we can configure are own settings. I always already makes sure I can find the Raspberry PI by setting a correct hostname, already make sure I can connect trough SSH and set the WIFI if I don't use Kabels.

### Preconfigure node
When you Raspberry PI is running, you can connect to it trough SSH. When connected please run the following commands to get this repo into local storage.

```
curl -sSL https://raw.githubusercontent.com/cmolendijk/k3s-pi-scripts/main/getting-started.sh | bash
```

Then run the following script to preconfigure a node.

```
bash $HOME/repos/k3s-pi-scripts/installation/preconfiguration.sh
```

Afther the reboot, login again and follow the install control node or the install worker node based on your needs.

### Install control node
When you are again connected trough ssh to the node that you want to make the control node.

```
cd $HOME/repos/k3s-pi-scripts
bash $HOME/repos/k3s-pi-scripts/installation/control-node.sh
```

### Install worker node
When you are again connected trough ssh to the node that you want to make the worker node.

```
bash $HOME/repos/k3s-pi-scripts/installation/worker-node.sh
```