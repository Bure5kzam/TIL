#!/bin/bash

apt-get install -yq tzdata &&
ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime &&
dpkg-reconfigure -f noninteractive tzdata

locale  # check for UTF-8
apt install locales
locale-gen en_US en_US.UTF-8
update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8

locale  # verify settings

apt install software-properties-common
echo | add-apt-repository universe

apt update && apt install -y curl
curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null

apt update && apt upgrade

sudo apt-get install -y \
	ros-humble-desktop \
	#ros-humble-ros-base \
	ros-dev-tools

echo 'source /opt/ros/humble/setup.bash' >> ~/.bashrc
