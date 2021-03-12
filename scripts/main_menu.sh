#!/bin/bash

# This scripts is intended to be a high level menu

old_IPS=${IPS}
IPS=$'\n'

OPT=( 'AGENDA'
    'APLICATIONS'
    'FILES'
    'SHUTDOWN'
    'REBOOT'
    'TERMINAL'
)

choice=$(printf "%s\n" "${OPT[@]}" | dmenu -i -l 5 -p 'CHOOSE OPTION')

if [ $? = 0 ]; then
    case $choice in
        'AGENDA') $HOME/scripts/viewcal.sh ;;
        'APLICATIONS') $HOME/scripts/app_menu.sh ;;
        'FILES') x-terminal-emulator -e ranger ;;
        'SHUTDOWN') shutdown -h now ;;
        'REBOOT') shutdown -r now ;;
        'TERMINAL') x-terminal-emulator ;;

    esac
fi

IPS=${old_IPS}

exit 0
