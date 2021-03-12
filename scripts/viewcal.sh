#!/bin/bash
#====================================
# This script uses dmenu to access pre-built aliases for querying calendar events/todo in calcurse application.
# - calcurse is needed
# - dmenu is needed
# - this script should be within a directory in PATH
#====================================

# looks for calcurse instalation
if [ -z $(which calcurse) ]; then
    exit 1
fi

old_IFS=${IPS} 
IFS=$'\n'

names=( 'open' )
commands=( 'x-terminal-emulator -e calcurse')

options=$(egrep '^\s*alias.*calcurse' $HOME/.bash_aliases | sed -E 's/.*alias ([[:alnum:]]*)\=\"(.*)\"/\1\t\2/')
names+=( $(echo "$options" | cut -f 1) )
commands+=( $(echo "$options" | cut -f 2) )
choice=$(printf "%s\n" "${names[@]}" | dmenu -l 5 -p '[AGENDA]')

if [ $? = 0 ]; then
    for index in "${!names[@]}"; do
        [ "${names[$index]}" = $choice ] &&  eval "${commands[$index]}"
    done
fi

IFS=${old_IFS}

exit 0
