export $(dbus-launch)
export GDK_BACKEND=x11
export QT_QPA_PLATFORM=xcb
export $(dbus-launch)

eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK
test -r /etc/X11/xinit/xinitrc.d/50-systemd-user.sh && source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh

exec bspwm
