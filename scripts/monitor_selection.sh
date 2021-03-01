#!/bin/sh
# This script will turn off every detected monitor which isnt the primary.
# It should be placed in /etc/lighdm directory and called in lightdm conf file.

# ===== Lightdm config file ======
# [Seat:*]
# ...
# display-setup-script=/etc/lightdm/monitor_selection.sh
# ...
# ================================

# check for xrandr in system
if [ -z "$(which xrandr)" ]; then 
    exit 1 
fi

old_IFS=${IFS}
IFS=$'\n' 

for out in `xrandr | grep connected | cut -d ' ' -f 1-3`; do
    # splitting the xrandr output stream
    name=`echo $out | cut -d ' ' -f 1`
    state=`echo $out | cut -d ' ' -f 2`
    key=`echo $out | cut -d ' ' -f 3`

    # if the display is connected and is not flagged as primary
    if [ "$state" = "connected" ]; then
        if [ ! "$key" = "primary" ]; then
            #turn it off
            xrandr --output $name --off
        fi
    fi
done

IFS=${old_IFS}

exit 0
