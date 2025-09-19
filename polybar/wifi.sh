#!/bin/bash

iface=$(nmcli -t -f DEVICE,TYPE,STATE dev | grep '^.*:wifi:connected' | cut -d: -f1)

if [ -n "$iface" ]; then
    signal=$(nmcli -t -f ACTIVE,SIGNAL dev wifi | grep '^yes' | cut -d: -f2)
    echo "$signal"
else
    echo "0"
fi