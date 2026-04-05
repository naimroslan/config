#!/usr/bin/env bash

uptime="$(uptime -p | sed -e 's/up //g;s/ minutes/m/g;s/ hours*,/h/g')"

hibernate='󰒲'
shutdown='󰐥'
reboot='󰜉'
lock='󰌾'
suspend='󰏤'
logout='󰍃'
yes=''
no=' '

rofi_cmd() {
	rofi -dmenu -p "  $USER" -mesg "  Uptime: $uptime" -config ~/.cache/wal/rofi-powermenu-config.rasi
}

confirm_cmd() {
	rofi -theme-str 'window {location: center; anchor: center; fullscreen: false; width: 350px;}' \
		-theme-str 'mainbox {orientation: vertical; children: [ "message", "listview" ];}' \
		-theme-str 'listview {columns: 2; lines: 1;}' \
		-theme-str 'element-text {horizontal-align: 0.5;}' \
		-theme-str 'textbox {horizontal-align: 0.5;}' \
		-dmenu -p 'Confirmation' -mesg 'Are you sure?' -config ~/.cache/wal/rofi-powermenu-config.rasi
}

run_rofi() { echo -e "$lock\n$reboot\n$logout\n$suspend\n$shutdown\n$hibernate" | rofi_cmd; }
confirm_exit() { echo -e "$yes\n$no" | confirm_cmd; }

run_cmd() {
	[[ "$(confirm_exit)" == "$yes" ]] || exit 0
	case $1 in
		--shutdown)  systemctl poweroff ;;
		--reboot)    systemctl reboot ;;
		--hibernate) systemctl hibernate ;;
		--suspend)   systemctl suspend ;;
		--logout)    hyprctl dispatch exit ;;
	esac
}

chosen="$(run_rofi)"
case ${chosen} in
    $shutdown)  run_cmd --shutdown ;;
    $reboot)    run_cmd --reboot ;;
    $hibernate) run_cmd --hibernate ;;
    $lock)      hyprlock ;;
    $suspend)   run_cmd --suspend ;;
    $logout)    run_cmd --logout ;;
esac
