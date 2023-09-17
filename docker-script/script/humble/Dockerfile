FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

LABEL USER = "KJH"
#LABEL PURPOSE = "using CGAL_classification"
# LABEL version = 2.1

ENV TZ=Etc/UTC
ENV S_INIT_APT_SH system_init_apt.sh
#ENV S_INIT_MORE_SH system_init_apt_add.sh
ENV S_INIT_ROS_SH system_init_ros.sh
ENV S_INIT_USER_SH system_init_user.sh

RUN apt update

# 필요한 스크립트 이동
WORKDIR /script
COPY --chown=root:root ./init/* ./

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

RUN ufw allow ssh

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
RUN ./${S_INIT_USER_SH}
USER wia
RUN umask 755

## ros 설치
RUN sudo ./${S_INIT_ROS_SH} -v humble

ENV DEBIAN_FRONTEND=interactive

CMD /bin/bash
