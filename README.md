# Raspberrypi Setup with Jupyter in Public network Without Monitor

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

# Boot Raspberry Pi and Enable I2C interface
Insert the microSD card to Raspberry Pi.<br/>
Download PuTTY from https://www.putty.org/<br/>
Open Putty with host name **raspberrypi**<br/>
Login as **pi**
Password **raspberry**
