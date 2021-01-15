# Raspberry Pi Setup with Jupyter Lab in Private network Without Monitor

## Install Raspberry Pi OS on microSD card
Download balenaEtcher from https://www.balena.io/etcher/<br/>
Download Raspberry Pi OS Lite from https://www.raspberrypi.org/software/operating-systems/<br/>
Install Raspberry Pi OS Lite with balenaEtcher on microSD card.

## Enable wifi and ssh
Create a file named **wpa_supplicant.conf** in the _boot_ directory of microSD card.<br/>
Open it with a text editor and write the followings. Make sure to replace the _wifi name_ and _password_ of your network.
```
country=US
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev 
update_config=1


network={
        ssid="wifi_name"
        psk="wifi_password"
        proto=RSN
        key_mgmt=WPA-PSK
        pairwise=CCMP
        auth_alg=OPEN
        id_str="phone"
        priority=9
}
```
Create a file named **ssh** in the same _boot_ directory and keep it blank.

## Boot Raspberry Pi
Insert the microSD card to Raspberry Pi.<br/>
Download PuTTY from https://www.putty.org/<br/>
Open Putty with host name **raspberrypi**<br/>
Login as **pi**<br/>
Password **raspberry**<br/>
 
## Enable I2C interface
Run following command in PuTTY.
```
sudo raspi-config
```
Select **3 Interface Optionn**, select **P5 I2C** and set **Yes**<br/>
Press **Tab** and select **Finish**

## Setup Jupyter Lab
Run following commands in PuTTY.
```
sudo apt install git -y
cd ~ && git clone https://github.com/ANI717/headless_raspberrypi_setup
cd ~/headless_raspberrypi_setup/jupyter_setup
chmod +x jupyter.sh && ./jupyter.sh [password]
```
The IP address (looks like 10.0.0.x) can be found from 1st element with following command.
```
hostname -I
```
Open Jupytar Lab in a browser from http://10.0.0.x:8888/ (make sure to provide the proper IP address).<br/>
Log in with [password], default is **raspberry**

## Install ROS1
Run following command to see total allocated memory.<br/>
```
free th
```
If memory is less than 1GB, run following commands to add extra 4GB swap memory.
```
sudo dd if=/dev/zero of=/swap1 bs=1M count=4096
sudo mkswap /swap1
sudo swapon /swap1
sudo bash -c "echo '/swap1 swap swap' >> /etc/fstab"
```
Reboot with following command.
```
sudo reboot
```
