[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

setxkbmap de
feh --bg-scale ~/Pictures/Wallpapers/Alejandra/_MG_6140.jpg &
sxhkd &
limones | lemonbar -B "#ff272822" -F "#fff8f8f2" -f "hack-9" -a "0" -p &

exec bspwm
