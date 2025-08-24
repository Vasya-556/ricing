#!/usr/bin/env bash

get_cpu_usage() {
    local interval=${1:-1}
    local cores=()

    while read -r line; do
        if [[ $line == cpu[0-9]* ]]; then
            cores+=("$line")
        fi
    done < /proc/stat

    local -a prev_idle prev_total
    for i in "${!cores[@]}"; do
        read -ra vals <<< "${cores[$i]}"
        idle=${vals[4]}
        total=0
        for v in "${vals[@]:1}"; do total=$((total + v)); done
        prev_idle[$i]=$idle
        prev_total[$i]=$total
    done

    sleep $interval

    local idx=0
    local -a usage_array
    while read -r line; do
        if [[ $line == cpu[0-9]* ]]; then
            read -ra vals <<< "$line"
            idle=${vals[4]}
            total=0
            for v in "${vals[@]:1}"; do total=$((total + v)); done

            diff_idle=$((idle - prev_idle[idx]))
            diff_total=$((total - prev_total[idx]))
            usage=$(( (100 * (diff_total - diff_idle)) / diff_total ))
            cpu_string="\"CPU $((idx+1)) = $usage%\""
            if [[ -z "$usage_array" ]]; then
                usage_array="$cpu_string"
            else
                usage_array="$usage_array,$cpu_string"
            fi

            ((idx++))
        fi
    done < /proc/stat

    eww update cpu_array="[$usage_array]"
    # echo "[${usage_array[*]}]"
}

get_cpu_usage 1