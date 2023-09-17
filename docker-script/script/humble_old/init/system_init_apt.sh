#!/bin/bash
DIRPATH="$(dirname $(readlink -f "$0"))/pkglist";

echo "$DIRPATH"

# - Set Repoistory
#sudo sed -i 's/archive.ubuntu.com/mirror.kakao.com/g' /etc/apt/sources.list

sudo apt update && sudo apt upgrade
sudo apt-get install < "$DIRPATH" 

