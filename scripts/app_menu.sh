#!/bin/bash

#
# This scripts is intended to provide a menu for chossing selected apps
#
# Most apps should be my default declared as en variables in bashrc scripts.
# set of env varibles must be set in .profile script (if .bash_profile and/or .bash_login are not set).

old_IPS=${IPS}
IPS=$'\n'

APP=( "$BROWSER"
"$MUSIC"
"$MAIL"
)

choices=$(dmenu_path | grep "$(echo "$(printf "%s\n" "${APP[@]}")")" | sort)
echo "$choices" | dmenu -p "[APPLICATION]" "$@" | ${SHELL:-"/bin/sh"} &

IPS=${old_IPS}

exit 0
