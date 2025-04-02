#!/usr/bin/env bash

SERVICE_NAME="wg-quick@"
STATUS_DISCONNECTED_STR='{"icon":"disconnected","text":"󰲝","alt":"disconnected"}'
CONFIG_DIR="/etc/wireguard"

function askpass() {
  wofi -dmenu -password -no-fixed-num-lines -p "Sudo password : " -theme ~/.config/waybar/wireguard/wofi.rasi
}

function status_wireguard() {
  systemctl is-active ${SERVICE_NAME}* >/dev/null 2>&1
  return $?
}

function list_configs() {
  SUDO_ASKPASS=~/.config/waybar/wireguard/wg-manager.sh sudo -A find "$CONFIG_DIR" -type f -name "*.conf" -exec basename {} .conf \;
}

function select_config() {
  selected_config=$(list_configs | wofi -dmenu -p "Select WireGuard config: " -theme ~/.config/waybar/wireguard/wofi.rasi)
  echo $selected_config
}

function toggle_wireguard() {
  if status_wireguard; then
    SUDO_ASKPASS=~/.config/waybar/wireguard/wg-manager.sh sudo -A systemctl stop ${SERVICE_NAME}*
  else
    selected_config=$(select_config)
    if [ -n "$selected_config" ]; then
      SUDO_ASKPASS=~/.config/waybar/wireguard/wg-manager.sh sudo -A systemctl start ${SERVICE_NAME}${selected_config}
    fi
  fi
}

function get_active_config() {
  if status_wireguard; then
    active_config=$(systemctl list-units --full -all ${SERVICE_NAME}* | grep -oP '(?<=wg-quick@)\w+')
    echo $active_config
  fi
}

case $1 in
-s | --status)
  if status_wireguard; then
    active_config=$(get_active_config)
    echo "{\"icon\":\"connected\",\"text\":\"󰱓 $active_config\",\"class\":\"connected\"}"
  else
    echo $STATUS_DISCONNECTED_STR
  fi
  ;;
-t | --toggle)
  toggle_wireguard
  ;;
*)
  askpass
  ;;
esac
