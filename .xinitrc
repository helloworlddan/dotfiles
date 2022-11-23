eval $(/usr/bin/pulseaudio --start --exit-idle-time=-1)
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)

export SSH_AUTH_SOCK
export $(dbus-launch)
export GDK_BACKEND=x11
export QT_QPA_PLATFORM=xcb
source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh

exec bspwm
