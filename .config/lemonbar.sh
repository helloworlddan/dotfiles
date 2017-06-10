#!/usr/bin/bash

clock() {
    date
}

battery() {
    cat /sys/class/power_supply/BAT0/capacity
}

host() {
    cat /etc/hostname
}

kernel() {
    uname -r
}

memory() {
	free -m | awk 'NR==2{printf "%.1f%%", $3*100/$2 }'
}

cpu() {
	echo $[100-$(vmstat 1 2|tail -1|awk '{print $15}')]
}

temp() {
	sensors | grep thinkpad-isa-0000 -A 5| grep temp1 | grep -o '+[0-9]*\.[0-9]°C'
}

fan() {
	sensors | grep thinkpad-isa-0000 -A 5| grep fan1 | grep -o '[0-9]* RPM'
}

desktop() {
	xprop -root _NET_CURRENT_DESKTOP | awk '{print $3+1}'
}

while true; do
    BAR_INPUT="%{l}$(host) | $(desktop) | Cpu: $(cpu)% $(temp) $(fan) | Mem: $(memory) | Bat: $(battery)% %{r}$(clock) | $(kernel)"
    echo $BAR_INPUT
    sleep 1
done
