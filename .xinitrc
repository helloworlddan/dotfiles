export $(dbus-launch)
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK
source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh
/usr/bin/pulseaudio --start --exit-idle-time=-1
exec bspwm
