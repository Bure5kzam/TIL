#!/bin/bash

# Function to display script usage
usage() {
    echo "Usage: $0 -v <version>"
    echo "Options:"
    echo "  -v <version>   ROS version to install (e.g., humble, foxy)"
    exit 1
}

# Parse command line options
while getopts ":v:" opt; do
    case ${opt} in
        v)
            version="$OPTARG"
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            usage
            ;;
        :)
            echo "Option -$OPTARG requires an argument." >&2
            usage
            ;;
    esac
done

# Check if the ROS version is specified
if [ -z "$version" ]; then
    echo "Error: ROS version not specified."
    usage
fi

# Install ROS common dependencies
apt-get install -yq tzdata &&
ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime &&
dpkg-reconfigure -f noninteractive tzdata

locale  # check for UTF-8
apt install -y locales
locale-gen en_US en_US.UTF-8
update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8

locale  # verify settings

apt install -y software-properties-common
echo | add-apt-repository universe

apt update && apt install -y curl
curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg

if [ "$version" = "humble" ]; then
    # Install ROS Humble
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null
    apt update && apt upgrade
    sudo apt-get install -y \
        ros-humble-desktop \
        #ros-humble-ros-base \
        ros-dev-tools
elif [ "$version" = "foxy" ]; then
    # Install ROS Foxy
		echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null
    apt update && apt upgrade
		sudo apt install -y ros-foxy-desktop python3-argcomplete \
				 ros-dev-tools
		# sudo apt install -y ros-foxy-ros-base \
		#		 python3-argcomplete \

elif [ "$version" = "galactic" ]; then
    # Install ROS Galactic
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null
    apt update && apt upgrade
    sudo apt install -y \
        ros-galactic-desktop \
        ros-dev-tools

    # colcon build
    echo "source /usr/share/colcon_cd/function/colcon_cd.sh" >> ~/.bashrc
    echo "export _colcon_cd_root=/opt/ros/galactic/" >> ~/.bashrc
    echo "source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash" >> ~/.bashrc

else
    echo "Error: Invalid ROS version specified."
    usage
fi

# echo "source /opt/ros/$version/setup.bash" >> ~/.bashrc
