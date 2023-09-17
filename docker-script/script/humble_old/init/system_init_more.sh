sudo apt install -y openssh-server

sudo ufw allow ssh

sudo apt install -y build-essential

sudo apt install -y net-tools

sudo apt-get install -y xrdp
sudo echo '[Allow Colord all Users]
Identity=unix-user:*
Action=org.freedesktop.color-manager.create-device;org.freedesktop.color-manager.create-profile;org.freedesktop.color-manager.delete-device;org.freedesktop.color-manager.delete-profile;org.freedesktop.color-manager.modify-device;org.freedesktop.color-manager.modify-profile
ResultAny=no
ResultInactive=no
ResultActive=yes' >> /etc/polkit-1/localauthority/50-local.d/45-allow-colord.pkla
sudo service xrdp start

sudo apt install -y xfce4 xfce4-goodies tightvncserver tigervnc-standalone-server tigervnc-xorg-extension mesa-utils websockify



