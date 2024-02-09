# k3S cluster on Raspberry PI
In this repo I share my hobby project where I install an K3S cluster on 5 raspberry pi 4B devices. The scripts are made for specific purpose but I try to make it more and more configurable where possible.

## Getting started
First we need to prepare our Raspberry Pi cards with a bootable. I use the [Raspberry PI Imager](https://www.raspberrypi.com/news/raspberry-pi-imager-imaging-utility/) for this and uses the following settings:
 - **Raspberry Pi Model:** RASPBERRY PI 4
 - **Opperating system:** RASPBERRY PI OS LITE (64-BIT)
 - **Storage device:** The devices that has my SD card

In the next step we can configure are own settings. I always already makes sure I can find the Raspberry PI by setting a correct hostname, already make sure I can connect trough SSH and set the WIFI if I don't use Kabels.
