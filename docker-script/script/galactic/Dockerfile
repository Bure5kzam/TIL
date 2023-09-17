
FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

LABEL USER = "KJH"
#LABEL PURPOSE = "using CGAL_classification"
# LABEL version = 2.1

# user관련 설정
ARG UNAME=wia
ARG VM_UID
ARG VM_GID

ENV TZ=Etc/UTC
ENV S_INIT_APT_SH system_init_apt.sh
ENV S_INIT_ROS_SH system_init_ros.sh
ENV S_INIT_USER_SH system_init_user.sh

RUN apt update && apt install -y apt-utils

# 필요한 스크립트 이동
WORKDIR /script
COPY --chown=root:root /init/* ./

# root 작업
## tzdata
RUN ./${S_INIT_APT_SH} -f pkglist_root \
      && ln -fs /usr/share/zoneinfo/Asia/Seoul /etc/localtime \
      && dpkg-reconfigure --frontend noninteractive tzdata


## open-ssh
RUN apt install -y openssh-server

## etc
RUN apt install -y terminator \
      neovim \
      build-essential \
      net-tools \
      xfce4 \
      xfce4-goodies \
      mesa-utils \
      websockify \
      ufw

## ufw
RUN ufw allow ssh \
      &&  mkdir -p /run/sshd \
      &&  chmod 755 /run/sshd \
      &&  ufw reload

## sshd
RUN sudo /usr/sbin/sshd -D &
RUN sudo service ssh start


#RUN apt-get clean && apt-get update \
#      vim \
#      git \
#      wget \
#      unzip \
#      gdb \
#      cgdb \
#      clang \
#      valgrind \
#      xvfb \
#      libboost-all-dev \
#      libeigen3-dev \
#      libgmp-dev \
#      libmpfr-dev



# 일반 작업
## user 설정
#RUN ./${S_INIT_USER_SH}
RUN apt install -y sudo
RUN groupadd -g ${VM_GID} wia
# RUN echo $VM_GID aaa
RUN useradd -rm \
      -s /bin/bash \
      -d /home/wia \
      -u $VM_UID \
      -g $VM_GID \
      -G sudo \
      wia \
      && echo 'wia:wia!2345' | chpasswd \
      && echo 'wia ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER wia


## ros 설치
#RUN sudo ./${S_INIT_ROS_SH} -v galactic

## 빌드 캐쉬를 위해 인라인으로 변경
RUN sudo apt-get install -yq tzdata \
      && sudo ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime \
      && sudo dpkg-reconfigure -f noninteractive tzdata

## locale
RUN sudo apt install -y locales \
      && sudo locale-gen en_US en_US.UTF-8 \
      && sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 \
      && export LANG=en_US.UTF-8 \
      && locale  # verify settings \
      && sudo apt install -y software-properties-common \
      && sudo add-apt-repository universe

## apt repository
RUN   sudo apt update && sudo apt install -y curl \
      && sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg

## Install ROS Galactic
RUN   sudo echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null \
      && sudo apt update && sudo apt -y upgrade \
      && sudo apt install -y \
      ros-galactic-desktop \
      ros-dev-tools

## colcon build
RUN   echo "source /usr/share/colcon_cd/function/colcon_cd.sh" >> ~/.bashrc \
      && echo "export _colcon_cd_root=/opt/ros/galactic/" >> ~/.bashrc \
      && echo "source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash" >> ~/.bashrc \
      && umask 755

ENV DEBIAN_FRONTEND=interactive

CMD /bin/bash
