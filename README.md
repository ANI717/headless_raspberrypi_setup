# Headless Raspberry Pi 4 Setup Without Monitor
Headless Raspberry Pi Setup with Jupyter Lab in Private Network Without Monitor. ROS Melodic, Deep Learning Modules and AWS Greengrass Setup Included.

## Colaborators
[Computer Fusion Laboratory (CFL) - Temple University College of Engineering](https://sites.temple.edu/cflab/people/)
* [Animesh Bala Ani](https://animeshani.com/)
* [Dr. Li Bai](https://engineering.temple.edu/about/faculty-staff/li-bai-lbai)

## Table of Contents  
* [Install Raspberry Pi OS on microSD card](#raspbian) <br/>
* [Enable wifi and ssh](#wifissh) <br/>
* [Boot Raspberry Pi](#boot) <br/>
* [Enable ARM I2C Interface](#i2c) <br/>
* [Setup Jupyter Lab](#jupyter) <br/>
* [Add Extra 4GB Swap Memory](#swap) <br/>
* [Install Deep Learning Packages](#deeplearn) <br/>
* [Install ROS Melodic](#melodic) <br/>
* [Install AWS Greengrass](#greengrass) <br/>

## Install Raspberry Pi OS on microSD card <a name="raspbian"></a>
Download the latest version of Raspberry Pi Imager from [here](https://www.raspberrypi.org/software/) and install it.<br/>
Download Raspberry Pi OS Image 64 bit Raspbian Buster from [here](https://downloads.raspberrypi.org/raspios_arm64/images/).<br/>
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

## Boot Raspberry Pi <a name="boot"></a>
Insert the microSD card to Raspberry Pi.<br/>
Download PuTTY from [here](https://www.putty.org/)<br/>
Open Putty with host name **raspberrypi**<br/>
Login as **pi**<br/>
Password **raspberry**<br/>
 
## Enable ARM I2C Interface <a name="i2c"></a>
Run following command in PuTTY.
```
sudo raspi-config
```
Select **Interfacing Options**, select **I2C** and set **Yes**<br/>
Press **Tab** and select **Finish**

## Setup Jupyter Lab <a name="jupyter"></a>
Run following commands in PuTTY.
```
sudo apt install git -y
cd ~ && git clone https://github.com/ANI717/headless_raspberrypi_setup
cd ~/headless_raspberrypi_setup/jupyter_setup
chmod +x jupyter.sh && ./jupyter.sh [password]
```
The IP address (looks like xxx.xx.xx.xxx) can be found from 1st element with following command.
```
hostname -I
```
Open Jupytar Lab in a browser from http://xxx.xx.xx.xxx:8888/ (make sure to provide the proper IP address).<br/>
Log in with [password], default is **raspberry**

## Add Extra 4GB Swap Memory <a name="swap"></a>
Run following commands to add extra 4GB swap memory.
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
Run following command to see total allocated memory.<br/>
```
free th
```

## Install Deep Learning Packages <a name="deeplearn"></a>
Run following commands to install PyTorch, Torchvision, Pandas, Matplotlib and OpenCV.
```
cd ~/headless_raspberrypi_setup
chmod +x deeplearning.sh && ./deeplearning.sh
```
Or run following commands to install manually.
```
sudo apt update
sudo apt install libopenblas-dev libblas-dev m4 cmake cython python3-yaml libatlas-base-dev -y
export ONNX_ML=1
git clone --recursive https://github.com/pytorch/pytorch
cd pytorch
sudo -E python3 setup.py install
python3 -m pip install --upgrade pip
python3 -m pip install torchvision
python3 -m pip install pandas
python3 -m pip install --upgrade Pillow
python3 -m pip install matplotlib
python3 -m pip install opencv-contrib-python
```
Takes aploximately 8 hours to complete installation.

## Install ROS Melodic <a name="melodic"></a>
Make sure that 4GB swap memory is allocated.<br/>
Install ROS Melodic with following commands.
```
cd ~/headless_raspberrypi_setup
chmod +x installros.sh && ./installros.sh
```
Takes aploximately 45 minutes to complete installation.

## Install AWS Greengrass <a name="greengrass"></a>
Install AWS Greengrass with following commands.
```
cd ~/headless_raspberrypi_setup
chmod +x greengrass.sh && ./greengrass.sh
```
Reboot with following command.
```
sudo reboot
```
