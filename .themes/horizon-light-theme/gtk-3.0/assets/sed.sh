#!/bin/sh
sed -i \
         -e 's/#FDF0ED/rgb(0%,0%,0%)/g' \
         -e 's/#1a1c23/rgb(100%,100%,100%)/g' \
    -e 's/#FDF0ED/rgb(50%,0%,0%)/g' \
     -e 's/#da103f/rgb(0%,50%,0%)/g' \
     -e 's/#fadad1/rgb(50%,0%,50%)/g' \
     -e 's/#1a1c23/rgb(0%,0%,50%)/g' \
	"$@"
