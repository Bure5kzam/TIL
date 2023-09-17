#!/bin/bash

apt-get update

useradd -rm \
	-s /bin/bash\
	-d /home/wia\
	-G sudo\
	wia

groups wia

echo 'wia:wia!2345' | chpasswd
