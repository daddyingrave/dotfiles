#!/bin/bash

wmctrl -lx | awk -v term=$TERMINAL '$3 !~ term { print $1 }' | while read -r wId
do
	wmctrl -i -c $wId
done

