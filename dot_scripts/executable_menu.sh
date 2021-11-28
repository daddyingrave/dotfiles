yes="Yes"
no="No"

yes_prompt() {
  echo -e "$yes\n$no" | rofi -p "Are you sure?" -dmenu
}

uptime=$(uptime -p | sed -e 's/up //g')

shutdown="Shutdown"
reboot="Reboot"
lock="Lock"
logout="Logout"

options="$shutdown\n$reboot\n$lock\n$logout"

chosen="$(echo -e "$options" | rofi -p "Uptime: $uptime" -dmenu)"

case $chosen in
  $shutdown)
	  ans=$(yes_prompt &)
	  if [[ $ans == "$yes" ]]; then
      ~/.scripts/close_windows.sh
      sleep 2
	  	systemctl poweroff
    else
	  	exit 0
    fi
    ;;
  $reboot)
    ans=$(yes_prompt &)
	  if [[ $ans == "$yes" ]]; then
      ~/.scripts/close_windows.sh
      sleep 2
	  	systemctl reboot 
    else
	  	exit 0
    fi
    ;;
  $lock)
    ans=$(yes_prompt &)
	  if [[ $ans == "$yes" ]]; then
      ~/.scripts/lock.sh
    else
	  	exit 0
    fi
    ;;
  $logout)
    ans=$(yes_prompt &)
	  if [[ $ans == "$yes" ]]; then
      ~/.scripts/close_windows.sh
      sleep 2
      i3-msg exit
    else
	  	exit 0
    fi
    ;;
esac

