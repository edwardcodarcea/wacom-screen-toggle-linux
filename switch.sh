#!/bin/sh

INPUTS=$(xinput list | grep -i wacom |perl -ne 'while (m/id=(\d+)/g){print "$1\n";}');
DISPLAYS=$(xrandr | grep 'connected' | cut -d " " -f 1);

# DISPLAY_WACOM=${WACOM_DISPLAY:=$(echo $DISPLAYS | cut -d " " -f 1)};
CONFIG_FILE=~/.wacom/.config;
if [ ! -f "$CONFIG_FILE" ]; then
	DISPLAY_WACOM="$(echo $DISPLAYS | cut -d " " -f 1)";
else
	DISPLAY_WACOM="$(cat "${CONFIG_FILE}")";

	disp=0;
	for d in $DISPLAYS
	do
		if [ "$d" = "$DISPLAY_WACOM" ]
		then
			disp=1;
		else
			if [ 1 -eq $disp ]
			then
				DISPLAY_WACOM="${d}";
				disp=2;
			fi
		fi
	done

	if [ 2 -ne $disp ]
	then
		DISPLAY_WACOM="$(echo $DISPLAYS | cut -d " " -f 1)";
	fi
fi

for id in $INPUTS
do
	echo "${id} -> ${DISPLAY_WACOM}";
	xsetwacom set "${id}" MapToOutput "${DISPLAY_WACOM}";
done

echo $DISPLAY_WACOM > "${CONFIG_FILE}";

