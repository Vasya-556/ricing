#!/bin/bash

change_colors=true
change_fonts=false
wallpaper_file=""

while [[ $# -gt 0 ]]; do
    case $1 in
    # no colors
        --c)
            change_colors=false
            shift
            ;;
    # update fonts
        --f)
            change_fonts=true
            shift
            ;;
        *)
            wallpaper_file="$1"
            shift
            ;;
    esac
done

if [[ -z "$wallpaper_file" ]]; then
    echo "Usage: $(basename "$0") [--c] [--f] <wallpaper_file>"
    exit 1
fi

if [[ -d "$wallpaper_file" ]]; then
    mapfile -t images < <(find "$wallpaper_file" -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' \))
    
    if [[ ${#images[@]} -eq 0 ]]; then
        echo "No image files found in directory: $wallpaper_file"
        exit 1
    fi

    wallpaper_file="${images[RANDOM % ${#images[@]}]}"
fi

wal -i "$wallpaper_file"

if $change_fonts; then
    ~/.config/scripts/update-fonts.sh
fi

if $change_colors; then
    ~/.config/scripts/update-colors.sh
fi

i3-msg restart