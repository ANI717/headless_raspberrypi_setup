# Headless Raspberry Pi 4 Setup with Jupyter Lab in Private Network Without Monitor

## Table of Contents  
[Install Raspberry Pi OS on microSD card](#raspbian) <br/>
[Enable wifi and ssh](#wifissh) <br/>

## Install Raspberry Pi OS on microSD card <a name="raspbian"></a>
Download the latest version of Raspberry Pi Imager from https://www.raspberrypi.org/software/ and install it.<br/>
Download Raspberry Pi OS Image 64 bit Raspbian Buster from https://downloads.raspberrypi.org/raspios_arm64/images/.<br/>
Install 64 bit Raspbian Buster with Raspberry Pi Imager on a microSD card.

## Enable wifi and ssh <a name="wifissh"></a>
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
Select **3 Interface Option**, select **P5 I2C** and set **Yes**<br/>
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

## Install ROS Melodic
Run following command to see total allocated memory.<br/>
```
free th
```
If memory is less than 3GB, run following commands to add extra 4GB swap memory.
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
Install ROS Melodic with following commands.
```
cd ~/headless_raspberrypi_setup
chmod +x installros.sh && ./installros.sh
```

## Install AWS Greengrass
Install AWS Greengrass with following commands.
```
cd ~/headless_raspberrypi_setup
chmod +x greengrass.sh && ./greengrass.sh
```
Reboot with following command.
```
sudo reboot
```
