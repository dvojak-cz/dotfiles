#!/bin/bash

RED="\e[31m"
NC="\e[0m" # No Color


get_load() {
    read one five fifteen rest < /proc/loadavg
    echo "CPU: $one $five $fifteen"
}
get_battery() {
    echo "BAT: $(acpi | awk '{print $3}' | tr -d ',') $(acpi | awk '{print $4}' | tr -d ',') $(acpi | awk '{print $5}')"
}
get_memory() {
    read total used free shared buff_cache available < <(free | grep Mem | awk '{print $2 " " $3 " " $4 " " $5 " " $6 " " $7}')
    echo "MEM: $(echo scale=1\; $used / 1024 / 1024  | bc ) / $(echo scale=1\; $total / 1024 / 1024  | bc )"
}
get_time() {
    echo "$(date '+%Y-%m-%d %H:%M:%S')"
}
get_ethernet() {
    local interface=$(ip link | grep -v lo | grep -v wl | awk '/state UP/ {print $2}' | sed 's/://g' | head -n 1)
    if [ -n "$interface" ]; then
        echo "E: UP"
    else
        echo "E: -"
    fi
}
get_wireless() {
    local interface=$(iw dev | grep Interface | awk '{print $2}' | head -n 1)
    if [[ -n "$interface" && $essid != "" ]]; then
        local quality=$(grep "$interface" /proc/net/wireless | awk '{ print int($3 * 100 / 70) "%" }')
        local essid=$(iwgetid -r)
        echo "W: ($quality at $essid)"
    else
        echo "W: -"
    fi
}

while true; do
  echo "$(get_wireless) | $(get_ethernet) | $(get_battery) | $(get_load) | $(get_memory) | $(get_time)"
  sleep 5
done
