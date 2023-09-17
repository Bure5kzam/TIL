#!/bin/sh
sudo apt-get install -y xrdp
sudo echo '[Allow Colord all Users]
Identity=unix-user:*
Action=org.freedesktop.color-manager.create-device;org.freedesktop.color-manager.create-profile;org.freedesktop.color-manager.delete-device;org.freedesktop.color-manager.delete-profile;org.freedesktop.color-manager.modify-device;org.freedesktop.color-manager.modify-profile
ResultAny=no
ResultInactive=no
ResultActive=yes' >> /etc/polkit-1/localauthority/50-local.d/45-allow-colord.pkla
sudo service xrdp start

unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
export QT_XKB_CONFIG_ROOT=/usr/share/X11/xkb
export XDG_RUNTIME_DIR=/tmp/runtime-wiaamr/
export RUNLEVEL=3
exec startxfce4
