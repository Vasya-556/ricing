#!/usr/bin/env bash

get_wifi_data() {
    nmcli dev wifi rescan >/dev/null 2>&1
    sleep 1 

    declare -A seen
    local -a wifi_lines

    current_ssid=$(nmcli -t -f ACTIVE,SSID dev wifi | grep '^yes' | cut -d: -f2)

    while IFS=: read -r ssid signal security; do
        [[ -z "$ssid" || "${seen[$ssid]}" ]] && continue
        seen[$ssid]=1

        [[ "$security" != "--" ]] && lock="LOCKED" || lock=""

        if [[ "$ssid" == "$current_ssid" ]]; then
            wifi_lines=("\"$ssid $signal% $lock\"")
        else
            wifi_lines+=("\"$ssid $signal% $lock\"")
        fi
    done < <(nmcli -t -f SSID,SIGNAL,SECURITY dev wifi | sort -t: -k2 -nr)

    local wifi_array
    wifi_array=$(IFS=,; echo "${wifi_lines[*]}")
    local wifi_json="[$wifi_array]"

    eww update wifi_list="$wifi_json"
    # echo "$wifi_json"
}

get_wifi_data 1