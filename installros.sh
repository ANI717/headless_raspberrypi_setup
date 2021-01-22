#!/bin/sh

sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
sudo apt-get update
sudo apt-get upgrade -y
sudo apt install -y python-rosdep python-rosinstall-generator python-wstool python-rosinstall build-essential cmake libboost-all-dev
sudo rosdep init
rosdep update
mkdir -p ~/ros_catkin_ws
cd ~/ros_catkin_ws
rosinstall_generator ros_comm --rosdistro melodic --deps --wet-only --tar > melodic-ros_comm-wet.rosinstall
wstool init src melodic-ros_comm-wet.rosinstall
cd ~/ros_catkin_ws/src
git clone https://github.com/ros/common_msgs
git clone https://github.com/ros/rosbag_migration_rule
cd ~/ros_catkin_ws
rosdep install -y --from-paths src --ignore-src --rosdistro melodic -r --os=debian:buster
sudo ./src/catkin/bin/catkin_make_isolated --install -DCMAKE_BUILD_TYPE=Release --install-space /opt/ros/melodic
echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc