#!/usr/bin/env bash

write_data_in_file(){
    mkdir -p "$(dirname "$2")"
    echo -n "$1" > "$2"
}

write_data_in_file "$1" "$2"